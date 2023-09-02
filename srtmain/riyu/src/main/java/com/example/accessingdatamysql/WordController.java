package com.example.accessingdatamysql;

import com.example.accessingdatamysql.tool.MyResponse;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.Objects;

import static java.lang.Math.min;

@Controller // This means that this class is a Controller
@RequestMapping(path="/demo") // This means URL's start with /demo (after Application path)
public class WordController {
    @Autowired // This means to get the bean called userRepository
    // Which is auto-generated by Spring, we will use it to handle the data
    private UserRepository userRepository;

    private static final Logger logger = LoggerFactory.getLogger(WordController.class);


    @Value("${file.upload.root.url}")
    private String userdataRootPath;
    @Value("${file.word.analyze.url}")
    private String wordPath;


    @CrossOrigin(origins = "*")
    @PostMapping(path="/word") // Map ONLY POST Requests
    public @ResponseBody String wordAnalyze (
            @RequestParam String token,
            @RequestParam("file") MultipartFile[] files,
            @RequestParam String accent) throws JSONException, IOException, InterruptedException {

        logger.debug("get word start");

        logger.debug(accent);

        String innerString = accent.substring(1, accent.length() - 1);

        logger.debug(innerString);

        String[] ac = innerString.split(", ");

        logger.debug("ac length");
        logger.debug(String.valueOf(ac.length));

        logger.debug(Arrays.toString(ac));

        JSONObject object=new JSONObject();

        String uploadFilePath = "";

        User user = userRepository.findByToken(token);

        if(user == null)
            return MyResponse.response_success("Bad token", 60000).toString();

        uploadFilePath = userdataRootPath + "/" + user.getDeviceId() + wordPath;

        for (MultipartFile file : files) {
            String fileName = file.getOriginalFilename();  // 文件名
            File dest = new File(uploadFilePath + '/' + fileName);

            logger.debug("upload filename: {}", fileName);
            logger.debug("upload file dest: {}", dest);

            assert fileName != null;
            if(!(fileName.toLowerCase().endsWith(".wav") || fileName.toLowerCase().endsWith(".m4a") || fileName.toLowerCase().endsWith(".mp3") )) {
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
        String dest2wavPath = uploadFilePath + '/' + files[0].getOriginalFilename();
        dest2wavPath = dest2wavPath.replace(".m4a", ".wav");
        dest2wavPath = dest2wavPath.replace(".mp3", ".wav");


        String command = "/home/ubuntu/anaconda3/bin/python";
        String scriptPath = "/home/ubuntu/srtmain/audTrans/audio_trans2wav.py";

        ProcessBuilder processBuilder = new ProcessBuilder(command, scriptPath, dest.toString(), dest2wavPath);

        logger.debug("cmd is {}", command +" "+ scriptPath +" "+ dest.toString() +" "+ dest2wavPath);
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

        command = "/home/ubuntu/anaconda3/bin/python";
        scriptPath = "/home/ubuntu/srtmain/praat/get_freq.py";

        processBuilder = new ProcessBuilder(command, scriptPath, dest2wavPath);

        logger.debug("cmd is {}", command + " " + scriptPath + " " + dest2wavPath);
        // 启动进程并执行命令
        process = processBuilder.start();

        // 读取命令的输出信息
        reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
        while ((line = reader.readLine()) != null) {
            logger.debug("now is the command out");
            logger.debug(line);
        }

        // 等待命令执行完成
        exitCode = process.waitFor();
        logger.debug("Command execution completed with exit code: " + exitCode);


        command = "/home/ubuntu/anaconda3/bin/python";
        scriptPath = "/home/ubuntu/srtmain/freqSmooth/smooth.py";

        processBuilder = new ProcessBuilder(command, scriptPath, dest2wavPath.replace(".wav", ".json"));

        logger.debug("cmd is {}", command + " " + scriptPath + " " + dest2wavPath);
        // 启动进程并执行命令
        process = processBuilder.start();

        // 读取命令的输出信息
        reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
        while ((line = reader.readLine()) != null) {
            logger.debug("now is the command out");
            logger.debug(line);
        }

        // 等待命令执行完成
        exitCode = process.waitFor();
        logger.debug("Command execution completed with exit code: " + exitCode);






        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode pitchNode = objectMapper.readTree(new File(dest2wavPath.replace(".wav", ".json")));

        JsonNode freqNode = pitchNode.get("freq");
        JsonNode timeNode = pitchNode.get("time");
        JsonNode startTimeNode = pitchNode.get("startTime");
        JsonNode endTimeNode = pitchNode.get("endTime");

        double startTime = startTimeNode.asDouble();
        double endTime = endTimeNode.asDouble();

        double[] freqArray = objectMapper.convertValue(freqNode, double[].class);

        double[] timeArray = objectMapper.convertValue(timeNode, double[].class);

        double[] startPoint = new double[ac.length];
        double[] endPoint = new double[ac.length];

        double interval = (endTime - startTime) / ac.length;

        double nowStart = startTime;
        for (int i = 0; i < ac.length; i++) {
            startPoint[i] = nowStart;
            nowStart += interval;
        }
        double nowEnd = startTime + interval;
        for (int i = 0; i < ac.length; i++) {
            endPoint[i] = nowEnd;
            nowEnd += interval;
        }

        double[] mean = new double[ac.length];

        double meanSum = 0;
        double meanNum = 0;
        int order = 0;

        logger.debug(Arrays.toString(freqArray));

        logger.debug((Arrays.toString(timeArray)));

        logger.debug(Arrays.toString(endPoint));

        logger.debug(Arrays.toString(startPoint));

        for (int i = 0; i < timeArray.length; i++) {
            if(order >= ac.length)
                break;

            if(startPoint[order] <= timeArray[i]) {
                if(freqArray[i] >= 0) {
                    meanSum += freqArray[i];
                    meanNum ++;
                }
            }
            if(endPoint[order] < timeArray[i]) {

                if(meanNum != 0)
                    mean[order] = meanSum / meanNum;
                else
                    mean[order] = -1;
                logger.debug("this is mean");
                logger.debug(String.valueOf(mean[order]));
                logger.debug("this is order");
                logger.debug(String.valueOf(order));
                order ++;
                meanNum = 0;
                meanSum = 0;
            }
        }

        if(meanNum > 0 && order < ac.length)
            mean[order] = meanSum / meanNum;

        logger.debug(Arrays.toString(mean));


        String[] wordRes = new String[ac.length];
        int resOrder = 0;

        JSONObject json = MyResponse.response_success("Success in word analyzing", 0);

        double freq0 = mean[0];
        double freq1 = 1000;


        logger.debug("this is accent");
        logger.debug(Arrays.toString(ac));

        double delta_freq = 5;


        if(Objects.equals(ac[0], "0")) {


            wordRes[resOrder++] = "0";

            for(; resOrder < ac.length; resOrder++) {
                logger.debug("this is resOrder");
                logger.debug(String.valueOf(resOrder));
                if(Objects.equals(ac[resOrder], "0")) {
                    if(mean[resOrder] + delta_freq < freq1) {
                        wordRes[resOrder] = "0";
                    }
                    else {
                        wordRes[resOrder] = "1";


                        String[] jsonRes = new String[resOrder + 1];
                        for(int k = 0; k <= resOrder; k++)
                            jsonRes[k] = wordRes[k];

                        JSONArray jsonArray = new JSONArray();
                        for (String element : jsonRes) {
                            jsonArray.put(element);
                        }
                        json.put("accent", jsonArray);
                        return json.toString();
                    }
                }
                else {

                    if(Objects.equals(ac[resOrder], "2")) {
                        wordRes[resOrder] = "2";
                        continue;
                    }

                    logger.debug(Arrays.toString(wordRes));
                    freq1 = min(freq1, mean[resOrder]);

                    if(mean[resOrder] > freq0 + delta_freq) {
                        wordRes[resOrder] = "1";
                    }
                    else {
                        wordRes[resOrder] = "0";

                        logger.debug(Arrays.toString(wordRes));

                        String[] jsonRes = new String[resOrder + 1];
                        for(int k = 0; k <= resOrder; k++)
                            jsonRes[k] = wordRes[k];

                        logger.debug(Arrays.toString(jsonRes));

                        JSONArray jsonArray = new JSONArray();
                        for (String element : jsonRes) {
                            jsonArray.put(element);
                        }
                        json.put("accent", jsonArray);
                        logger.debug("jump out");
                        return json.toString();

                    }
                }
            }

            String[] jsonRes = new String[resOrder];
            for(int k = 0; k < resOrder; k++)
                jsonRes[k] = wordRes[k];

            JSONArray jsonArray = new JSONArray();
            for (String element : jsonRes) {
                jsonArray.put(element);
            }
            json.put("accent", jsonArray);
            return json.toString();
        }
        else if(Objects.equals(ac[0], "1")) {
            freq1 = mean[resOrder];

            wordRes[resOrder] = "1";
            resOrder++;

            for(; resOrder < ac.length; resOrder++) {
                if(Objects.equals(ac[resOrder], "2")) {
                    wordRes[resOrder] = "2";
                    continue;
                }
                if(mean[resOrder] + delta_freq < freq1) {
                    wordRes[resOrder] = "0";
                }
                else {
                    wordRes[resOrder] = "1";
                    String[] jsonRes = new String[resOrder + 1];
                    for(int k = 0; k <= resOrder; k++)
                        jsonRes[k] = wordRes[k];

                    JSONArray jsonArray = new JSONArray();
                    for (String element : jsonRes) {
                        jsonArray.put(element);
                    }
                    json.put("accent", jsonArray);
                    return json.toString();
                }
            }

            String[] jsonRes = new String[resOrder];
            for(int k = 0; k < resOrder; k++)
                jsonRes[k] = wordRes[k];

            JSONArray jsonArray = new JSONArray();
            for (String element : jsonRes) {
                jsonArray.put(element);
            }
            json.put("accent", jsonArray);
            return json.toString();
        }

        logger.debug(Arrays.toString(wordRes));


        String[] jsonRes = new String[resOrder + 1];
        for(int k = 0; k <= resOrder; k++)
            jsonRes[k] = wordRes[k];

        JSONArray jsonArray = new JSONArray();
        for (String element : jsonRes) {
            jsonArray.put(element);
        }
        json.put("accent", jsonArray);
        return json.toString();

//        return "12";
    }
}
