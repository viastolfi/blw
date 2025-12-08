#include "raylib.h"

#define RAYGUI_IMPLEMENTATION
#include "thirdparty/raygui.h"

int main()
{
  InitWindow(500, 300, "BATTERY LEVEL WARNER");
  SetTargetFPS(60);
  bool leave = false;

  while (!WindowShouldClose() && !leave)
  {
    BeginDrawing();
    ClearBackground(GetColor(GuiGetStyle(DEFAULT, BACKGROUND_COLOR)));

    DrawText("You battery level is bellow 20% !", 80, 100, 20, LIGHTGRAY);

    if (GuiButton((Rectangle){ 0, 200, 500, 100}, "#191#Understand !")) leave = true;

    EndDrawing();
  }

  CloseWindow();
  return 0;
}
