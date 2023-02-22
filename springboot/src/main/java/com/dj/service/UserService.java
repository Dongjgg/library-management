package com.dj.service;

import com.dj.controller.request.BaseRequest;
import com.dj.controller.request.UserPageRequest;
import com.dj.pojo.Admin;
import com.dj.pojo.User;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface UserService {
    List<User> list();

    PageInfo<User> page(BaseRequest baseRequest);

    void save(User user);

    User getById(Integer id);

    void update(User user);

    void deleteById(Integer id);

    void handleAccount(User user);
}
