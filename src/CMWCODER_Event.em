event DocumentOpen(sFile) {
  PutEnv("CMWCODER_tab", "o" # sFile)
}

event DocumentClose(sFile) {
  PutEnv("CMWCODER_tab", "c" # sFile)
}

event ProjectOpen(sProject) {
  Event_init()
}

event AppStart() {
  Event_init()
}

event AppShutdown() {}

macro Event_init() {
  global isInit
  
  Config_init()
  isInit = true
}

event DocumentSelectionChanged(sFile) {
  hcurrentWnd = GetCurrentWnd()
  if (hcurrentWnd != hnil) {
    cursor = GetWndSel(hcurrentWnd)
    if (cursor.lnFirst != cursor.lnLast || cursor.ichFirst != cursor.ichLim) {
      Env_SetSelection(cursor)
    }
  }
}
