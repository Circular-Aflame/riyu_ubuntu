package com.example.accessingdatamysql;

import java.io.*;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Objects;
import java.util.Scanner;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller // This means that this class is a Controller
@RequestMapping(path="/demo") // This means URL's start with /demo (after Application path)
public class FileUploadController {
    private static final Logger logger = LoggerFactory.getLogger(FileUploadController.class);


    @Value("${file.upload.url}")
    private String uploadFilePath;

    @PostMapping(path = "/upload")
    public @ResponseBody String httpUpload(@RequestParam String username
            , @RequestParam String token, @RequestParam("file") MultipartFile[] files) throws JSONException, IOException, InterruptedException {
        JSONObject object=new JSONObject();
        for (MultipartFile file : files) {
            String fileName = file.getOriginalFilename();  // 文件名
            File dest = new File(uploadFilePath + '/' + fileName);

            logger.debug("upload filename: {}", fileName);
            logger.debug("upload file dest: {}", dest);

            assert fileName != null;
            if(!fileName.toLowerCase().endsWith(".wav")) {
                object.put("code", 60000);
                object.put("info", "Bad file extension");
                return object.toString();
            }

            if (!dest.getParentFile().exists()) {
                dest.getParentFile().mkdirs();
            }
            try {
                file.transferTo(dest);
            } catch (Exception e) {
                object.put("code", 60000);
                object.put("info", "Save fail");
                return object.toString();
            }
        }
        File dest = new File(uploadFilePath + '/' + files[0].getOriginalFilename());

        String command = "/home/ubuntu/anaconda3/bin/python3";
        String scriptPath = "/home/ubuntu/srtmain/vosk/vosk-api/python/example/test_ffmpeg.py";
        String audioFilePath = dest.toString();

        ProcessBuilder processBuilder = new ProcessBuilder(command, scriptPath, audioFilePath);

        logger.debug("cmd is {}", command + scriptPath + audioFilePath);
        // 启动进程并执行命令
        Process process = processBuilder.start();


        // 读取命令的输出信息
        BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
        String line;
        while ((line = reader.readLine()) != null) {
            logger.debug("now is the command out");
            logger.debug(line);
        }

        // 等待命令执行完成
        int exitCode = process.waitFor();
        logger.debug("Command execution completed with exit code: " + exitCode);


        String vosk_result_path = dest.toString();
        vosk_result_path = vosk_result_path.replace(".wav", ".txt");
        logger.debug("this is vosk result path");
        logger.debug(vosk_result_path);
        String vosk_result = "";

        try (Scanner sc = new Scanner(new FileReader(vosk_result_path))) {
            if (sc.hasNextLine()) {
                 vosk_result = sc.nextLine();
                 vosk_result = vosk_result.replace(" ", "");
                 logger.debug("now is the vosk result that will be return to http");
                 logger.debug(vosk_result);
            }
        }


        object.put("code",0);
        object.put("info","Success in upload");
        if(Objects.equals(vosk_result, "")) {
            object.put("data", "voice so low or so short");
        }
        else {
            object.put("data", vosk_result);
        }

        return object.toString();
    }
}
