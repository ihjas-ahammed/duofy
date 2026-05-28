#include <webview_cef/webview_cef_plugin.h>
#include "my_application.h"
#include <cstdlib>

int main(int argc, char** argv) {
  // initCEFProcesses calls CefExecuteProcess; for CEF subprocesses (renderer,
  // GPU, zygote) it exits immediately — they never reach g_application_run.
  initCEFProcesses(argc, argv);

  g_autoptr(MyApplication) app = my_application_new();
  return g_application_run(G_APPLICATION(app), argc, argv);
}
