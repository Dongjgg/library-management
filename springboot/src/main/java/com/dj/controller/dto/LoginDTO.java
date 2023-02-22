package com.dj.controller.dto;

import jdk.nashorn.internal.parser.Token;
import lombok.Data;

@Data
public class LoginDTO {
    private Integer id;
    private String username;
    private String phone;
    private String email;
    private String token;
}
