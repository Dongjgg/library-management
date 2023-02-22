package com.dj.controller.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class PasswordRequest {
    private String username;
    private String password;
    private String newPass;
}
