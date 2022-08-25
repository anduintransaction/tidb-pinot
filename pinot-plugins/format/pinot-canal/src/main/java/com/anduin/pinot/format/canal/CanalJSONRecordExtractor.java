package com.anduin.pinot.format.canal;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Nullable;

import org.apache.pinot.spi.data.readers.BaseRecordExtractor;
import org.apache.pinot.spi.data.readers.GenericRow;
import org.apache.pinot.spi.data.readers.RecordExtractorConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.common.collect.ImmutableSet;

public class CanalJSONRecordExtractor extends BaseRecordExtractor<Map<String, Object>> {
  private static final Logger LOGGER = LoggerFactory.getLogger(CanalJSONRecordExtractor.class);

  private Set<String> _fields;
  private boolean _extractAll = false;

  @Override
  public void init(Set<String> fields, @Nullable RecordExtractorConfig recordExtractorConfig) {
    LOGGER.info("Using {}", CanalJSONRecordExtractor.class.getName());
    if (fields == null || fields.isEmpty()) {
      _extractAll = true;
      _fields = Collections.emptySet();
    } else {
      _fields = ImmutableSet.copyOf(fields);
    }
  }

  @Override
  public GenericRow extract(Map<String, Object> from, GenericRow to) {
    if (CdcCodec.extractIsDDL(from)) {
      to.putValue(GenericRow.SKIP_RECORD_KEY, true);
      return to;
    }

    Set<String> fields = _fields;
    if (_extractAll) {
      fields = from.keySet();
    }

    List<Map<String, Object>> data = CdcCodec.extractData(from);
    Object ts = convert(CdcCodec.extractTS(from));
    boolean isDeleted = CdcCodec.extractEventType(from).equals("DELETE");

    List<GenericRow> rows = new ArrayList<>();
    for (Map<String, Object> entry : data) {
      GenericRow row = extractFields(entry, fields);
      row.putValue("ts", ts);
      row.putValue("__deleted", isDeleted);
      rows.add(row);
    }

    to.putValue(GenericRow.MULTIPLE_RECORDS_KEY, rows);
    return to;
  }

  private GenericRow extractFields(Map<String, Object> from, Set<String> fields) {
    GenericRow row = new GenericRow();
    for (String fieldName : fields) {
      Object value = from.get(fieldName);
      if (value != null) {
        value = convert(value);
      }
      row.putValue(fieldName, value);
    }
    return row;
  }
}
