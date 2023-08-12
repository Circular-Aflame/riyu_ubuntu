package com.example.accessingdatamysql.tool;

import com.example.accessingdatamysql.User;
import com.example.accessingdatamysql.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class UserUtils {
    private static UserRepository userRepository;


    @Value("${file.upload.root.url}")
    private static String uploadFileRootPath;
    @Value("${file.cache.url}")
    private static String cachePath;
    @Value("${file.consistent.save.url}")
    private static String consistentPath;

    @Autowired
    public UserUtils(UserRepository userRepository) {
        UserUtils.userRepository = userRepository;
    }

    public static String getUserFolderCachePathByToken(String token) {
        User user = userRepository.findByToken(token);
        if (user != null) {
            // 根据用户信息计算文件夹路径
            return uploadFileRootPath + "/" + user.getDeviceId() + cachePath;
        }
        return null; // 如果找不到对应的用户，则返回null
    }

    public static String getUserFolderRootPathByToken(String token) {
        User user = userRepository.findByToken(token);
        if (user != null) {
            // 根据用户信息计算文件夹路径
            return uploadFileRootPath + "/" + user.getDeviceId();
        }
        return null; // 如果找不到对应的用户，则返回null
    }
    
    public static String getUserFolderConsistPathByToken(String token) {
        User user = userRepository.findByToken(token);
        if (user != null) {
            // 根据用户信息计算文件夹路径
            return uploadFileRootPath + "/" + user.getDeviceId() + consistentPath;
        }
        return null; // 如果找不到对应的用户，则返回null
    }
}
