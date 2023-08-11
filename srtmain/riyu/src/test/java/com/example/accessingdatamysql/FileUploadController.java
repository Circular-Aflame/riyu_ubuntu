package com.example.accessingdatamysql;


import net.minidev.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;


@Controller
public class FileUploadController {
    @Autowired
    private UserRepository userRepository;

    @Value("${file.upload.url}")
    private String uploadFilePath;

    @PostMapping(path="/demo/upload") // Map ONLY POST Requests
    public @ResponseBody String addNewUser (@RequestParam("file") MultipartFile[] files) {

        JSONObject object=new JSONObject();
        for (MultipartFile file : files) {
            String fileName = file.getOriginalFilename();  // 文件名
            File dest = new File(uploadFilePath + '/' + fileName);
            if (!dest.getParentFile().exists()) {
                dest.getParentFile().mkdirs();
            }
            try {
                file.transferTo(dest);
            } catch (Exception e) {
                object.put("code", 60000);
                object.put("info", "Bad username");
                return object.toString();
            }
        }
        object.put("code", 0);
        object.put("info","Success in upload and get result");
        return object.toString();
    }
}
