package com.anduin.pinot.format.canal;

import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

public class CdcCodec {
  private static final ObjectMapper MAPPER = new ObjectMapper();
  private static final TypeReference<List<Map<String, Object>>> DATA_TYPE_REFERENCE = new TypeReference<List<Map<String, Object>>>() {
  };

  public static final String DDL_KEY = "isDdl";
  public static final String DATA_KEY = "data";
  public static final String TABLE_TYPE_KEY = "mysqlType";
  public static final String TS_KEY = "es";
  public static final String EVENT_TYPE_KEY = "type";

  public static List<Map<String, Object>> extractData(Map<String, Object> from) {
    return MAPPER.convertValue(
        from.get(DATA_KEY),
        DATA_TYPE_REFERENCE);
  }

  public static long extractTS(Map<String, Object> from) {
    return (Long) from.get(TS_KEY);
  }

  public static Map<String, String> extractColMeta(Map<String, Object> from) {
    return (Map<String, String>) from.get(TABLE_TYPE_KEY);
  }

  public static boolean extractIsDDL(Map<String, Object> from) {
    return (Boolean) from.get(DDL_KEY);
  }

  public static String extractEventType(Map<String, Object> from) {
    String t = (String) from.get(EVENT_TYPE_KEY);
    return t.toUpperCase();
  }
}
