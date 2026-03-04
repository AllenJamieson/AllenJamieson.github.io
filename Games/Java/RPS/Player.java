import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;

public class Player {
    public static Socket socket;
    public static JLabel wl;
    public static void main(String[] args) throws IOException {
        socket = new Socket(args[1], Integer.parseInt(args[0]));
        DataOutputStream out = new DataOutputStream(socket.getOutputStream());
        JFrame app = new JFrame(socket.toString());
        app.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        app.setSize(100, 200);
        app.setLayout(new GridLayout(4, 1));
        wl = new JLabel();
        JButton rock = new JButton("Rock");
        JButton papper = new JButton("Paper");
        JButton scissors = new JButton("Scissors");
        new Thread(new Reader()).start();

        app.addWindowListener(new WindowAdapter() {
            @Override
            public void windowClosing(WindowEvent e) {
                try { socket.close(); }
                catch (IOException e1) { System.out.println("Failed to Close Socket"); }
            }
        });

        rock.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try { out.writeChar('r'); }
                catch (IOException e1) { System.out.println("Failed to write"); }
            }
        });
        papper.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try { out.writeChar('p'); }
                catch (IOException e1) { System.out.println("Failed to write"); }
            }
        });
        scissors.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try { out.writeChar('s'); }
                catch (IOException e1) { System.out.println("Failed to write"); }
            }
        });
        app.add(wl);
        app.add(rock);
        app.add(papper);
        app.add(scissors);
        app.setVisible(true);
    }

    public static class Reader implements Runnable {
        @Override
        public void run() {
            try {
                DataInputStream in = new DataInputStream(socket.getInputStream());
                while (true) wl.setText(in.readUTF());
            } catch (IOException e) { System.out.println("Closed"); }
        }
    }
}