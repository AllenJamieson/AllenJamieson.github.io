import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class RPS {
    private static byte player_index = 0;
    private static char p1_rps = ' ';
    private static Socket[] players = new Socket[2];

    public static void main(String[] args) throws IOException {
        ServerSocket server = new ServerSocket(Integer.parseInt(args[0]));
        while (player_index < 2) {
            Socket player = server.accept();
            System.out.println("Player: " + player);
            players[player_index++] = player;
            Handler handler = new Handler(player);
            new Thread(handler).start();
        }
        server.close();
    }

    public static void process(Socket player, char data) throws IOException {
        DataOutputStream p1_out = new DataOutputStream(players[0].getOutputStream());
        DataOutputStream p2_out = new DataOutputStream(players[1].getOutputStream());
        if(player_index < 2) return;
        if(p1_rps == ' ' && player.equals(players[0])) {
            p1_rps = data;
        }
        if(p1_rps != ' ' && player.equals(players[1])) {
            if(p1_rps == data) {
                p1_out.writeUTF("Tie");
                p2_out.writeUTF("Tie");
            }
            if(
                (p1_rps == 'p' && data == 'r') ||
                (p1_rps == 'r' && data == 's') ||
                (p1_rps == 's' && data == 'p')
            ) {
                p1_out.writeUTF("You Win");
                p2_out.writeUTF("You Lose");
            }
            if(
                (p1_rps == 'r' && data == 'p') ||
                (p1_rps == 's' && data == 'r') ||
                (p1_rps == 'p' && data == 's')
            ) {
                p2_out.writeUTF("You Win");
                p1_out.writeUTF("You Lose");
            }
            p1_rps = ' ';
        }
    }

    private static class Handler implements Runnable {
        private Socket socket;

        public Handler(Socket socket) {this.socket = socket;}

        @Override
        public void run() {
            try {
                DataInputStream in = new DataInputStream(socket.getInputStream());
                while (!socket.isClosed()) {
                    process(socket, in.readChar());
                }
            } catch (IOException e) { System.out.println("Closed"); }            
        }
    }
}
