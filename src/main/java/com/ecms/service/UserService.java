package com.ecms.service;

import com.ecms.entity.User;
import java.util.List;

public interface UserService {
    List<User> getAllUsers();
    User getUserById(Integer id);
    User getUserByUsername(String username);
    User createUser(User user);
    User updateUser(User user);
    void deleteUser(Integer id);
    
    /**
     * 用户登录
     * @param username 用户名
     * @param password 密码
     * @return 登录成功返回用户对象，失败返回null
     */
    User login(String username, String password);
    
    /**
     * 用户注册
     * @param user 用户信息
     * @return 注册成功的用户对象
     */
    User register(User user);
    
    /**
     * 用户注册
     * @param username 用户名
     * @param password 密码
     * @return 注册成功的用户对象
     */
    User register(String username, String password);
}