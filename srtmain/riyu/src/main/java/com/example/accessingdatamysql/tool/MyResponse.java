package com.example.accessingdatamysql.tool;

import org.json.JSONException;
import org.json.JSONObject;

public class MyResponse {
    public static JSONObject response_success(String info, Integer code) throws JSONException {
        JSONObject object = new JSONObject();
        object.put("info", info);
        object.put("code", code);
        return object;
    }
}
