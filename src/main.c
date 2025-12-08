#include "raylib.h"

#define RAYGUI_IMPLEMENTATION
#include "thirdparty/raygui.h"

int main(int argc, char** argv)
{
  if (argc < 2) {
    fprintf(stderr, "blw program should take at least 1 argument\n");
    return 1;
  }
  InitWindow(500, 300, "BATTERY LEVEL WARNER");
  SetTargetFPS(60);
  bool leave = false;
  char battery_indicator[255];

  sprintf(battery_indicator, "You battery level is bellow %s% !", argv[1]);

  while (!WindowShouldClose() && !leave)
  {
    BeginDrawing();
    ClearBackground(GetColor(GuiGetStyle(DEFAULT, BACKGROUND_COLOR)));

    DrawText(battery_indicator, 80, 100, 20, LIGHTGRAY);

    if (GuiButton((Rectangle){ 0, 200, 500, 100}, "#191#Understand !")) leave = true;

    EndDrawing();
  }

  CloseWindow();
  return 0;
}
