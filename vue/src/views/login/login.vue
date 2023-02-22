<template>
    <div style="height: 100vh; overflow: hidden; position: relative">

        <el-card class="cover" v-if="loginAdmin.id">
            <slide-verify :l="42"
                          :r="10"
                          :w="310"
                          :h="155"
                          slider-text="向右滑动"
                          @success="onSuccess"
                          @fail="onFail"
                          @refresh="onRefresh"
            ></slide-verify>
        </el-card>


        <div style="width: 500px; height: 400px; background-color: white; border-radius: 10px; margin: 150px auto; padding: 50px">
            <div style="margin: 30px; text-align: center; font-size: 30px; font-weight: bold; color: dodgerblue">登 录</div>
            <el-form :model="admin" ref="loginForm" :rules="rules">
                <el-form-item prop="username">
                    <el-input placeholder="请输入账号" prefix-icon="el-icon-user" size="medium" v-model="admin.username"></el-input>
                </el-form-item>
                <el-form-item prop="password">
                    <el-input placeholder="请输入密码" show-password prefix-icon="el-icon-lock" size="medium" v-model="admin.password"></el-input>
                </el-form-item>
                <el-form-item>
                    <el-button style="width: 100%;" size="medium" type="primary" @click="login">登录</el-button>
                </el-form-item>
            </el-form>
        </div>
    </div>
</template>

<script>
    import request from "@/utils/request";
    import Cookies from 'js-cookie'

    export default {
        name: "login",
        data(){
            return{
                loginAdmin: {},
                admin: {},
                rules: {
                    username: [
                        { required: true, message: '请输入账号', trigger: 'blur'},
                        {min:3, max: 10, message: '长度在3-10个字符', trigger: 'blur'}
                    ],
                    password: [
                        { required: true, message: '请输入密码', trigger: 'blur'},
                        {min:3, max: 10, message: '长度在3-10个字符', trigger: 'blur'}
                    ]
                }
            }
        },
        methods: {
            login(){
                this.$refs['loginForm'].validate((valid)=>{
                    if (valid){
                        request.post('/admin/login',this.admin).then(res=>{
                            if (res.code==='200'){
                                this.loginAdmin = res.data    //loginAdmin 有值之后滑块组件就会出现
                            }else{
                                this.$notify.error(res.msg)
                            }
                        })
                    }
                })
            },
            onSuccess() {  //滑块验证通过成功之后
                this.$notify.success("登录成功")
                Cookies.set('admin',JSON.stringify(this.loginAdmin)) //设置cookie
                //要先设置cookie，配合路由守卫才行
                this.$router.push('/')
            },
            onFail() {

            },
            onRefresh() {
                console.log('refresh')
            }
        }
    }
</script>

<style scoped>
    .cover {
        width: fit-content;
        background-color: white;
        position: absolute;
        top:50%;
        left:50%;
        transform: translate(-50%, -50%);
        z-index: 1000;
    }
</style>