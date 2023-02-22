package com.dj.mapper;

import com.dj.controller.request.BaseRequest;
import com.dj.controller.request.LoginRequest;
import com.dj.controller.request.PasswordRequest;
import com.dj.controller.request.UserPageRequest;
import com.dj.pojo.Admin;
import com.dj.pojo.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Mapper
public interface AdminMapper {

    @Select("select * from admin")
    List<Admin> list();

    List<Admin> listByCondition(BaseRequest baseRequest);

    void save(Admin admin);

    Admin getById(Integer id);

    void updateById(Admin admin);

    void deleteById(Integer id);

    Admin getByUserNameAndPassword(@PathVariable("username")String username,@PathVariable("password")String password);

    int updatePassword(PasswordRequest request);

    Admin getByUsername(String username);
}
