<template>
  <el-header>
    <div class="navbar">
      <el-menu
          :default-active="activeIndex"
          class="menu"
          @select="handleSelect"
          mode="horizontal"
      >
        <el-menu-item index="">首页</el-menu-item>
        <el-menu-item index="products">产品管理</el-menu-item>
        <el-menu-item index="orders">订单管理</el-menu-item>

      </el-menu>
    </div>
  </el-header>
</template>

<script>
export default {
  name: 'AppNavbar', // 修改组件名称为多词
  data() {
    return {
      activeIndex: 'home' // 默认激活的菜单项
    };
  },
  methods: {
    handleSelect(index) {
      this.activeIndex = index;
      // 跳转到对应的页面
      this.$router.push({ name: index }); // 假设使用 Vue Router
    }
  }
};
</script>

<style scoped>
.navbar {
  background-color: #409eff; /* Element Plus 的主题颜色 */
  color: #ffffff;
}
.menu {
  line-height: 60px; /* 使菜单项垂直居中 */
}
</style>
