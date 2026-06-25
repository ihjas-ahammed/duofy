#include <webview_cef/webview_cef_plugin.h>
#include "my_application.h"
#include <cstdlib>

int main(int argc, char** argv) {
  // Fix keyboard input blocking issues with certain input methods (IBus / Fcitx) in Flutter on Linux.
  setenv("GTK_IM_MODULE", "xim", 1);

  // initCEFProcesses calls CefExecuteProcess; for CEF subprocesses (renderer,
  // GPU, zygote) it exits immediately — they never reach g_application_run.
  initCEFProcesses(argc, argv);

  g_autoptr(MyApplication) app = my_application_new();
  return g_application_run(G_APPLICATION(app), argc, argv);
}
