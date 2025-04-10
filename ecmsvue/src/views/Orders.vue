<template>
  <div>
    <AppNavbar />
    <h1>订单管理</h1>
    <el-input
        v-model="searchKeyword"
        placeholder="请输入订单编号进行搜索"
        style="width: 300px; margin-bottom: 20px;"
        @input="fetchOrdersByKeyword"
    />
    <el-button type="primary" @click="showOrderForm" style="margin-bottom: 20px;">添加订单</el-button>

    <!-- 订单表格 -->
    <el-table :data="orders" style="width: 100%;">
      <el-table-column prop="orderNumber" label="订单编号" />
      <el-table-column prop="totalAmount" label="总金额">
        <template #default="scope">
          ¥{{ scope.row.totalAmount.toFixed(2) }}
        </template>
      </el-table-column>
      <el-table-column prop="orderStatus" label="状态">
        <template #default="scope">
          <el-tag :type="getStatusTagType(scope.row.orderStatus)">
            {{ getStatusText(scope.row.orderStatus) }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作">
        <template #default="scope">
          <el-button size="small" @click="editOrder(scope.row)">编辑</el-button>
          <el-button size="small" type="danger" @click="confirmDelete(scope.row.orderId)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 订单表单对话框 -->
    <el-dialog
        v-model="dialogVisible"
        :title="selectedOrder ? '编辑订单' : '添加订单'"
        width="50%"
        @close="clearForm"
    >
      <el-form :model="orderForm" label-width="120px" size="medium">
        <el-form-item label="订单编号" prop="orderNumber">
          <el-input v-model="orderForm.orderNumber" placeholder="请输入订单编号" />
        </el-form-item>
        <el-form-item label="总金额" prop="totalAmount">
          <el-input-number v-model="orderForm.totalAmount" :min="0" :precision="2" />
        </el-form-item>
        <el-form-item label="状态" prop="orderStatus">
          <el-select v-model="orderForm.orderStatus" placeholder="选择状态">
            <el-option label="待处理" value="pending" />
            <el-option label="已发货" value="shipped" />
            <el-option label="已完成" value="completed" />
            <el-option label="已退款" value="refunded" />
          </el-select>
        </el-form-item>
        <el-form-item label="商家ID" prop="merchantId">
          <el-input-number v-model="orderForm.merchantId" :min="1" disabled v-if="selectedOrder" />
          <el-input-number v-model="orderForm.merchantId" :min="1" v-else />
        </el-form-item>
        <el-form-item label="顾客ID" prop="customerId">
          <el-input-number v-model="orderForm.customerId" :min="1" disabled v-if="selectedOrder" />
          <el-input-number v-model="orderForm.customerId" :min="1" v-else />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="saveOrder">保存</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script>
import axios from 'axios';
import { ElMessage, ElMessageBox } from 'element-plus';
import AppNavbar from "@/components/Navbar.vue";

export default {
  name: 'OrderManagement',
  components: {AppNavbar},
  data() {
    return {
      orders: [],
      searchKeyword: '', // 新增搜索关键词
      orderForm: {
        orderNumber: '',
        totalAmount: 0,
        orderStatus: 'pending',
        merchantId: null,
        customerId: null
      },
      selectedOrder: null,
      dialogVisible: false
    };
  },
  methods: {
    getStatusTagType(status) {
      const map = {
        pending: 'warning',
        shipped: 'primary',
        completed: 'success',
        refunded: 'danger'
      };
      return map[status] || '';
    },
    getStatusText(status) {
      const map = {
        pending: '待处理',
        shipped: '已发货',
        completed: '已完成',
        refunded: '已退款'
      };
      return map[status] || status;
    },
    fetchOrders() {
      axios.get('http://localhost:8080/api/orders')
          .then(response => {
            this.orders = response.data;
          })
          .catch(error => {
            ElMessage.error('获取订单列表失败: ' + error.message);
            console.error('获取订单时出错:', error);
          });
    },
    fetchOrdersByKeyword() {
      const url = this.searchKeyword
          ? `http://localhost:8080/api/orders/search?keyword=${this.searchKeyword}`
          : 'http://localhost:8080/api/orders';

      axios.get(url)
          .then(response => {
            this.orders = response.data;
          })
          .catch(error => {
            ElMessage.error('获取订单列表失败: ' + error.message);
            console.error('获取订单时出错:', error);
          });
    },
    showOrderForm() {
      this.selectedOrder = null;
      this.orderForm = {
        orderNumber: '',
        totalAmount: 0,
        orderStatus: 'pending',
        merchantId: null,
        customerId: null
      };
      this.dialogVisible = true;
    },
    editOrder(order) {
      this.selectedOrder = order;
      this.orderForm = {
        orderNumber: order.orderNumber,
        totalAmount: order.totalAmount,
        orderStatus: order.orderStatus,
        merchantId: order.merchantId,
        customerId: order.customerId
      };
      this.dialogVisible = true;
    },
    clearForm() {
      this.selectedOrder = null;
      this.orderForm = {
        orderNumber: '',
        totalAmount: 0,
        orderStatus: 'pending',
        merchantId: null,
        customerId: null
      };
    },
    saveOrder() {
      const url = this.selectedOrder
          ? `http://localhost:8080/api/orders/${this.selectedOrder.orderId}`
          : 'http://localhost:8080/api/orders';

      const method = this.selectedOrder ? 'put' : 'post';

      const orderData = {
        merchantId: this.orderForm.merchantId,
        customerId: this.orderForm.customerId,
        orderNumber: this.orderForm.orderNumber,
        totalAmount: this.orderForm.totalAmount,
        orderStatus: this.orderForm.orderStatus
      };

      axios[method](url, orderData)
          .then(() => {
            ElMessage.success(this.selectedOrder ? '订单更新成功' : '订单添加成功');
            this.fetchOrders();
            this.dialogVisible = false;
          })
          .catch(error => {
            ElMessage.error('操作失败: ' + error.message);
            console.error('保存订单时出错:', error);
          });
    },
    confirmDelete(orderId) {
      ElMessageBox.confirm(
          '确定要删除这个订单吗？此操作不可撤销。',
          '警告',
          {
            confirmButtonText: '确认删除',
            cancelButtonText: '取消',
            type: 'warning',
          }
      )
          .then(() => {
            this.deleteOrder(orderId);
          })
          .catch(() => {
            ElMessage.info('已取消删除');
          });
    },
    deleteOrder(orderId) {
      axios.delete(`http://localhost:8080/api/orders/${orderId}`)
          .then(() => {
            ElMessage.success('订单删除成功');
            this.fetchOrders();
          })
          .catch(error => {
            ElMessage.error('删除失败: ' + error.message);
            console.error('删除订单时出错:', error);
          });
    }
  },
  mounted() {
    this.fetchOrders(); // 初始加载所有订单
  }
};
</script>

<style scoped>
.el-table {
  width: 100%;
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
}
</style>
