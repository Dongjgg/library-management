package com.dj.service;


import com.dj.controller.dto.LoginDTO;
import com.dj.controller.request.BaseRequest;
import com.dj.controller.request.LoginRequest;
import com.dj.controller.request.PasswordRequest;
import com.dj.pojo.Admin;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface AdminService {
    List<Admin> list();

    PageInfo<Admin> page(BaseRequest baseRequest);

    void save(Admin admin);

    Admin getById(Integer id);

    void update(Admin admin);

    void deleteById(Integer id);

    LoginDTO login(LoginRequest loginRequest);

    void changePass(PasswordRequest request);
}
