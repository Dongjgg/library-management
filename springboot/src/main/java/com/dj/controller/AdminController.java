package com.dj.controller;

import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import com.dj.common.Result;
import com.dj.controller.dto.LoginDTO;
import com.dj.controller.request.AdminPageRequest;
import com.dj.controller.request.LoginRequest;
import com.dj.controller.request.PasswordRequest;
import com.dj.pojo.Admin;
import com.dj.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("/admin")
public class AdminController {


    @Autowired
    private AdminService adminService;

    @PutMapping("/password")
    public Result password(@RequestBody PasswordRequest request){
        adminService.changePass(request);
        return Result.success();
    }

    @PostMapping("/login")
    public Result login(@RequestBody LoginRequest loginRequest){
        LoginDTO login = adminService.login(loginRequest);
        return Result.success(login);
    }

    @PostMapping("/save")
    public Result save(@RequestBody Admin admin){
        adminService.save(admin);
        return Result.success();
    }

    @PutMapping("/update")
    public Result update(@RequestBody Admin admin){
        adminService.update(admin);
        return Result.success();
    }

    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id){
        adminService.deleteById(id);
        return Result.success();
    }

    @GetMapping("/{id}")
    public Result getById(@PathVariable Integer id){
        Admin admin = adminService.getById(id);
        return Result.success(admin);
    }


    @RequestMapping("/list")
    public Result list(){
        List<Admin> userList = adminService.list();
        return Result.success(userList);
    }

    @GetMapping("/page")
    public Result page(AdminPageRequest adminPageRequest){
        return Result.success(adminService.page(adminPageRequest));
    }




}
