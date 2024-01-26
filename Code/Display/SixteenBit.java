package Display;

public class SixteenBit extends Display {

    public static final int[] COLORS = {
        Integer.parseInt("000000", 16),
        Integer.parseInt("0000AA", 16),
        Integer.parseInt("00AA00", 16),
        Integer.parseInt("00AAAA", 16),
        Integer.parseInt("AA0000", 16),
        Integer.parseInt("AA00AA", 16),
        Integer.parseInt("AA5500", 16),
        Integer.parseInt("AAAAAA", 16),
        Integer.parseInt("555555", 16),
        Integer.parseInt("5555FF", 16),
        Integer.parseInt("55FF55", 16),
        Integer.parseInt("55FFFF", 16),
        Integer.parseInt("FF5555", 16),
        Integer.parseInt("FF55FF", 16),
        Integer.parseInt("FFFF55", 16),
        Integer.parseInt("FFFFFF", 16)
    };

    @Override
    public void rewriteImage(int v, int h) {
                int actRed          = (img.getRGB(h, v)   & 0x00ff0000) >> 16,
                    actGreen        = (img.getRGB(h, v)   & 0x0000ff00) >> 8,
                    actBlue         = img.getRGB(h, v)    & 0x000000ff;
                
                double lowestDist = Integer.MAX_VALUE;
                int color = 0;
                for (int c = 0; c < COLORS.length; c++) {
                    int currentRed      = (COLORS[c]    & 0x00ff0000) >> 16,
                        currentGreen    = (COLORS[c]    & 0x0000ff00) >> 8,
                        currentBlue     = COLORS[c]     & 0x000000ff;
                    double dist = Math.sqrt( Math.pow(actRed-currentRed, 2) + Math.pow(actGreen-currentGreen, 2) + Math.pow(actBlue-currentBlue, 2) );
                    if(lowestDist >= dist) {
                        lowestDist = dist;
                        color = c;
                    }
                }
                setImage(v, h,
                    (COLORS[color] & 0x00ff0000) >> 16,
                    (COLORS[color] & 0x0000ff00) >> 8,
                    COLORS[color]  & 0x000000ff
                );
    }

    @Override
    public String toString() {
        return "Sixteen Bit";
    }
    
}
