//配置的入口
import Vue from 'vue'
import App from './App.vue'
import router from './router'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import '@/assets/global.css'  //@符号表示src目录
import SlideVerify from 'vue-monoplasty-slide-verify';  //滑块验证组件
Vue.use(SlideVerify);

Vue.config.productionTip = false
Vue.use(ElementUI,{size: 'small'});  //样式组件大小 medium small mini


new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
