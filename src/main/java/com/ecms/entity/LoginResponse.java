package com.ecms.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LoginResponse {
    private String message; // 登录结果消息
    private Integer userId; // 用户ID
    private String role; // 用户角色
}
