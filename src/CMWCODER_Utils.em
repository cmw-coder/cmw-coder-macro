macro Utils_findFirst(left, right) {
  leftIndex = 0
  while (leftIndex < strlen(left) - strlen(right) + 1) {
    rightIndex = 0
    while (rightIndex < strlen(right)) {
      if (left[leftIndex + rightIndex] != right[rightIndex]) {
        break
      }
      if (rightIndex == strlen(right) - 1) {
        return leftIndex;
      }
      rightIndex = rightIndex + 1
    }
    leftIndex = leftIndex + 1
  }
  return invalid
}

macro strcmp(left, right) {
  index = 0
  while (left[index]) {
    if (left[index] != right[index]) {
      return AsciiFromChar(left[index]) - AsciiFromChar(right[index])
    }
  }
  return 0
}

macro sleep(int) {
  int= int * 250
  cout = 0
  while (cout < int) {
    cout = cout + 1
  }
}

macro ComparePre(str, substr) {
  sublen = strlen(substr)
  strlen = strlen(str)

  if (strlen < sublen) {
    return 0
  }
  tmpbuf = strmid(str, 0, sublen)
  //msg("ComparePre  tmpbuf: " # tmpbuf # " substr: " # substr)
  if (tmpbuf == substr) {
    return 1
  } else {
    return 0
  }
}

macro calcuSizes(sFile) {
  lenth = strlen(sFile)
  sizes = "000" + lenth
  if (strlen(sizes) < 3) {
    sizes = cat("0", sizes)
  }
  return sizes
}

macro Utils_isCLangFile(sFile) {
  return (
    Utils_findFirst(sFile, ".c") != invalid ||
    Utils_findFirst(sFile, ".h") != invalid
  )
}

macro cutstr(source, cutter) {
  cutIndex = Utils_findFirst(source, cutter);
  if (cutIndex == invalid) {
    return source
  }
  return cat(
    strmid(source, 0, cutIndex),
    strmid(source, cutIndex + strlen(cutter), strlen(source))
  )
}

macro Utils_getCurrentCursor() {
  hCurrentWnd = GetCurrentWnd()
  if (hCurrentWnd) {
    return GetWndSel(hCurrentWnd)
  }
}

macro Utils_getCurrentLine() {
  hCurrentBuf = GetCurrentBuf()
  if (hCurrentBuf) {
    return GetBufLine(hCurrentBuf, GetBufLnCur(hCurrentBuf))
  }
}

macro isEnter(Cache) {
  if (Cache.completebuf != nil) {
    //msg("isEnter(Cache)")
    CurrentCursor = Utils_getCurrentCursor()
    if (CurrentCursor.lnFirst > Cache.rangeStartLine) {
      return 1
    } else if (CurrentCursor.lnFirst < Cache.rangeStartLine) {
      return 2
    }
  }
  return 0
}

macro Utils_DateTimeNow() {
  timeInfo = GetSysTime(false)
  date = timeInfo.Year # "/" # timeInfo.Month # "/" # timeInfo.Day
  time = (timeInfo.Hour + 8) # ":" # timeInfo.Minute # ":" # timeInfo.Second # "." # timeInfo.Milliseconds
  return date # " " # time
}

macro strstr(str1,str2) {
    i = 0
    j = 0
    len1 = strlen(str1)
    len2 = strlen(str2)
    if ((len1 == 0) || (len2 == 0)) {
      return 0xffffffff
    }

    while ( i < len1) {
      if (str1[i] == str2[j]) {
        while (j < len2) {
          j = j + 1
          if (str1[i+j] != str2[j]) {
            break
          }
        }
        if (j == len2) {
          return i
        }
        j = 0
      }
      i = i + 1
    }
    return 0xffffffff
}
