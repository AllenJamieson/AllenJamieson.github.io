#include "picosystem.hpp"

using namespace picosystem;

#define PI 3.1415926536
#define TEXT_PADDING 5

// OBJECT BOUNDS
#define PADDLE_W 4
#define PADDLE_H 20
#define PLAYER_X 10
#define COMP_X 110
#define BALL_R 4

// CENTERS
#define PADDLE_CENTER PADDLE_H/2
#define SCREEN_SIZE 120 // This is a square screen
#define CENTER SCREEN_SIZE/2

#define PADDLE_SPEED 1
#define BALL_SPEED 1.5

// VOICE
#define SOUND_ATTACK 100
#define SOUND_DECAY 50
#define SOUND_SUS 80
#define SOUND_REL 200
#define SOUND_BEND 0
#define SOUND_BEND_MS 100
#define SOUND_REVERB 0
#define SOUND_NOISE 10
#define SOUND_DISTORT 0

// PLAY
#define SOUND_FREQ 750
#define SOUND_DUR 50
#define SOUND_VOL 100

float player_y, comp_y, ball_x, ball_y, ball_dir;
uint32_t player_score, comp_score;
voice_t bounce_sound;

void set_ball(bool to_player) {
    ball_x = CENTER;
    ball_y = CENTER;
    if(to_player) ball_dir = PI;
    else ball_dir = 0;
}

void reset_ball(bool lose) {
    if(lose) comp_score++;
    else player_score++;
    set_ball(lose);
}

void bounce() {
    play(bounce_sound, SOUND_FREQ, SOUND_DUR, SOUND_VOL);
}

void paddle_collision(bool is_player) {
    bounce();
    float diff = ball_y - PADDLE_CENTER; // THERE IS THE BALL RADIUS
    if(is_player) diff -= player_y;
    else diff -= comp_y;
    ball_dir = diff * PI / (PADDLE_H + (2 * BALL_R));
    if(!is_player) {
        ball_dir += PI;
        ball_dir = -ball_dir;
    }
}

bool paddle_collide(float x, float y) {
    return intersects (
                      ball_x-BALL_R, ball_y-BALL_R,
                      2*BALL_R, 2*BALL_R,
                      x, y, PADDLE_W, PADDLE_H
                      );
}

void init() {
    player_score = 0;
    comp_score = 0;
    player_y = CENTER - PADDLE_CENTER;
    comp_y = CENTER - PADDLE_CENTER;
    set_ball(true);
    bounce_sound =
        voice (
              SOUND_ATTACK,
              SOUND_DECAY,
              SOUND_SUS,
              SOUND_REL,
              SOUND_BEND,
              SOUND_BEND_MS,
              SOUND_REVERB,
              SOUND_NOISE,
              SOUND_DISTORT
              );
}

void update(uint32_t tick) {
    if(button(UP) && player_y > PADDLE_SPEED) player_y -= PADDLE_SPEED;
    if(button(DOWN) && player_y + PADDLE_H < SCREEN_SIZE) player_y += PADDLE_SPEED;
    if(comp_y + PADDLE_CENTER < ball_y) comp_y += PADDLE_SPEED;
    if(comp_y + PADDLE_CENTER > ball_y) comp_y -= PADDLE_SPEED;
    
    if(ball_x - BALL_R <= 0 || ball_x + BALL_R >= SCREEN_SIZE) reset_ball(ball_x - BALL_R <= 0);
    if(paddle_collide(PLAYER_X, player_y)) paddle_collision(true);
    if(paddle_collide(COMP_X, comp_y)) paddle_collision(false);
    if(ball_y - BALL_R <= 0 || ball_y + BALL_R >= SCREEN_SIZE) {
        bounce();
        ball_dir = -ball_dir;
    }

    if(ball_dir < 0) ball_dir += 2*PI;
    ball_x += (fcos(ball_dir) * BALL_SPEED);
    ball_y += (fsin(ball_dir) * BALL_SPEED);
}

void draw(uint32_t tick) {
    pen(0, 0, 0);
    clear();
    pen(15, 15, 15);
    
    text("Player: "+str(player_score), TEXT_PADDING, TEXT_PADDING);
    text("Comp : "+str(comp_score), CENTER + TEXT_PADDING, TEXT_PADDING);
    vline(CENTER, 0, SCREEN_SIZE);
    
    frect(PLAYER_X, player_y, PADDLE_W, PADDLE_H);
    frect(COMP_X, comp_y, PADDLE_W, PADDLE_H);
    fcircle(ball_x, ball_y, BALL_R);
}
