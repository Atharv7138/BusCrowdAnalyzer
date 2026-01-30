package readhardware;

import com.buscrowd.ConnectionDB;
import com.fazecast.jSerialComm.SerialPort;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;



import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class HardwareReader 
{
	static int flag=0;
    public static void main(String[] args) {

        SerialPort port = SerialPort.getCommPort("COM3");
        port.setBaudRate(9600);
        port.setComPortTimeouts(SerialPort.TIMEOUT_NONBLOCKING, 0, 0);

        if (!port.openPort()) {
            System.err.println("Port not opened");
            return;
        }

        System.out.println("Reading data...");

        StringBuilder buffer = new StringBuilder();

        try (InputStream in = port.getInputStream()) {

            while (true) {
                while (in.available() > 0) {
                    char ch = (char) in.read();

                    // End of message
                    if (ch == '\n') {
                        String message = buffer.toString().trim();
                        buffer.setLength(0);

                        if (message.isEmpty()) continue;

                        System.out.println("Received Raw: " + message);

                        // Parse JSON safely
                        try {
                            JsonObject obj = JsonParser.parseString(message).getAsJsonObject();
                            //{"id":MH15AB1001,"lat":20.014961,"lon":73.765694,"button":1,"count":1}
                            String id = obj.has("id") ? obj.get("id").getAsString() : "0";
                            double lat = obj.has("lat") ? obj.get("lat").getAsDouble() : 0;
                            double lon = obj.has("lon") ? obj.get("lon").getAsDouble() : 0;
                            int button = obj.has("button") ? obj.get("button").getAsInt() : 0;
                            int count = obj.has("count") ? obj.get("count").getAsInt() : 0;
                            int capacity = 0;
                            
                            String broute = null;
                            String demail = null;
                            System.out.println("id     : " + id);
                            System.out.println("lat    : " + lat);
                            System.out.println("lon    : " + lon);
                            System.out.println("button : " + button);
                            System.out.println("count  : " + count);
                            System.out.println("---------------------------");
                            
                            Connection con = ConnectionDB.getCon();
                            PreparedStatement ps1 = con.prepareStatement("update buses set lat=?, lon=?, count=? where busnumber=?");
                            ps1.setDouble(1, lat);
                            ps1.setDouble(2, lon);
                            ps1.setInt(3, count);
                            ps1.setString(4, id);
                            int i = ps1.executeUpdate();
                            if(i>0)
                            {
                            	System.out.println("\t\tDATA UPDATED IN DB..");
                            	i=0;
                            }
                            else
                            {
                            	System.err.println("\t\tDATA UPDATION FAILED..");
                            }
                            
                            PreparedStatement ps2 = con.prepareStatement("Select * from buses where busnumber=?");
                            ps2.setString(1, id);
                            ResultSet rs = ps2.executeQuery();
                            if(rs.next())
                            {
                            	capacity=Integer.parseInt(rs.getString("capacity"));
                            	broute = rs.getString("busroute");
                            	demail = rs.getString("demail");
                            }
                            if(count>=capacity && flag==1)
                            {
                            	System.out.println("\t\tBUS CAPACITY EXCEED.. ASSIGNING NEW BUS..!!");
                            	PreparedStatement ps3 = con.prepareStatement("SELECT * FROM extra_buses WHERE demail=? ORDER BY RAND() LIMIT 1");
                            	ps3.setString(1, demail);
                            	ResultSet rs1 = ps3.executeQuery();
                            	if(rs1.next())
                            	{
                            		PreparedStatement ps4 = con.prepareStatement("Update extra_buses set busroute=? where id=?");    
                            		ps4.setString(1, broute);
                            		ps4.setInt(2, rs1.getInt("id"));
                            		int k=ps4.executeUpdate();
                            		if(k>0)
                            		{
                            			System.out.println("\t\tNEW BUS ALLOCATED..!!");
                            			flag=1;
                            		}
                            		else
                            		{
                            			System.err.println("Extra Bus not available or FAILED..!!");
                            		}
                            	}
                            	
                        	}
                        } catch (Exception e) {
                            System.err.println("Invalid JSON skipped: " + message);
                        }

                    } else {
                        buffer.append(ch);
                    }
                }

                Thread.sleep(50); // CPU friendly
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}