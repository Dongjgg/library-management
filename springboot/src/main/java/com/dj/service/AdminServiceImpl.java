package com.dj.service;

import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import com.dj.controller.request.PasswordRequest;
import com.dj.exception.ServiceException;
import com.dj.controller.dto.LoginDTO;
import com.dj.controller.request.BaseRequest;
import com.dj.controller.request.LoginRequest;
import com.dj.mapper.AdminMapper;
import com.dj.pojo.Admin;
import com.dj.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Slf4j
@Service
public class AdminServiceImpl implements AdminService {
    private static final String PASS_SALT = "123";

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public List<Admin> list() {
        return adminMapper.list();
    }

    @Override
    public PageInfo<Admin> page(BaseRequest baseRequest) {
        PageHelper.startPage(baseRequest.getPageNum(),baseRequest.getPageSize());
        List<Admin> userList = adminMapper.listByCondition(baseRequest);
        return new PageInfo<>(userList);
    }

    @Override
    public void save(Admin admin) {
        //给一个默认密码
        if (StrUtil.isBlank(admin.getPassword())){
            admin.setPassword(PASS_SALT);
        }
        admin.setPassword(securePass(admin.getPassword())); //设置md5加密
        try{
            adminMapper.save(admin);
        }catch (Exception e){ //DuplicateKeyException
            log.error("数据插入失败，username：{}",admin.getUsername());
            throw new ServiceException("用户名已存在");
        }
    }

    @Override
    public Admin getById(Integer id) {
        return adminMapper.getById(id);
    }

    @Override
    public void update(Admin admin) {
        admin.setUpdatetime(new Date());
        adminMapper.updateById(admin);
    }

    @Override
    public void deleteById(Integer id) {
        adminMapper.deleteById(id);
    }

    @Override
    public LoginDTO login(LoginRequest loginRequest) {
        //判断账号是否合法
        Admin admin = null;
        try {
            admin = adminMapper.getByUsername(loginRequest.getUsername());
        }catch (Exception e){
            log.error("根据用户名{}，查询出错",loginRequest.getUsername());
            throw new ServiceException("用户名错误");
        }
        if (admin==null){
            throw new ServiceException("用户名或密码错误");
        }
        //判断密码是否合法
        String securePass = securePass(loginRequest.getPassword());
        if (!securePass.equals(admin.getPassword())){
            throw new ServiceException("用户名或密码错误");
        }

        if (!admin.isStatus()){
            throw new ServiceException("当前用户处于禁用状态，请联系管理员");
        }
        //属性复制只会复制loginDto类里面有的属性
        LoginDTO loginDTO = new LoginDTO();
        BeanUtils.copyProperties(admin,loginDTO);
        String token = TokenUtils.genToken(String.valueOf(admin.getId()), admin.getPassword()); //以密码作为密钥生成token
        loginDTO.setToken(token);
        return loginDTO;
    }

    @Override
    public void changePass(PasswordRequest request) {
        //注意要对新的密码进行加密
        request.setNewPass(securePass(request.getNewPass()));
        int i = adminMapper.updatePassword(request);
        if (i<=0){
            throw new ServiceException("修改密码失败");
        }
    }

    //加密方法，封装
    private String securePass(String password){
        return SecureUtil.md5(password);
    }
}
