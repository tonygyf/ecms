<template>
  <div>
    <AppNavbar />
    <h1>产品管理</h1>
    <el-input
        v-model="searchKeyword"
        placeholder="请输入产品名称或描述进行搜索"
        style="width: 300px; margin-bottom: 20px;"
        @input="fetchProductsByKeyword"
    />
    <el-button type="primary" @click="showProductForm" style="margin-bottom: 20px;">添加产品</el-button>

    <!-- 产品表格 -->
    <el-table :data="products" style="width: 100%;">
      <el-table-column prop="productName" label="产品名称" />
      <el-table-column prop="price" label="价格" />
      <el-table-column prop="status" label="状态">
        <template #default="scope">
          <el-tag :type="scope.row.status === 'active' ? 'success' : 'danger'">
            {{ scope.row.status === 'active' ? '可用' : '不可用' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作">
        <template #default="scope">
          <el-button size="small" @click="editProduct(scope.row)">编辑</el-button>
          <el-button size="small" type="danger" @click="confirmDelete(scope.row.productId)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 产品表单对话框 -->
    <el-dialog
        v-model="dialogVisible"
        :title="selectedProduct ? '编辑产品' : '添加产品'"
        width="50%"
        @close="clearForm"
    >
      <el-form :model="productForm" label-width="120px" size="medium">
        <el-form-item label="产品名称" prop="productName">
          <el-input v-model="productForm.productName" placeholder="请输入产品名称" />
        </el-form-item>
        <el-form-item label="价格" prop="price">
          <el-input-number v-model="productForm.price" :min="0" :precision="2" />
        </el-form-item>
        <el-form-item label="库存数量" prop="stockQuantity">
          <el-input-number v-model="productForm.stockQuantity" :min="0" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="productForm.status" placeholder="选择状态">
            <el-option label="可用" value="active" />
            <el-option label="不可用" value="inactive" />
          </el-select>
        </el-form-item>
        <el-form-item label="商家ID" prop="merchantId">
          <el-input-number v-model="productForm.merchantId" :min="1" disabled v-if="selectedProduct" />
          <el-input-number v-model="productForm.merchantId" :min="1" v-else />
        </el-form-item>
        <el-form-item label="描述" prop="description">
          <el-input v-model="productForm.description" type="textarea" :rows="3" />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="saveProduct">保存</el-button>
        </span>
      </template>
    </el-dialog>

    <!-- 删除确认对话框 -->
    <el-dialog
        v-model="deleteDialogVisible"
        title="确认删除"
        width="30%"
    >
      <span>确定要删除这个产品吗？此操作不可撤销。</span>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="deleteDialogVisible = false">取消</el-button>
          <el-button type="danger" @click="deleteProduct">确认删除</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script>
import axios from 'axios';
import { ElMessage } from 'element-plus';
import AppNavbar from "@/components/Navbar.vue";

export default {
  name: 'ProductManagement',
  components: {AppNavbar},
  data() {
    return {
      products: [],
      searchKeyword: '', // 新增搜索关键词
      productForm: {
        productName: '',
        price: 0,
        stockQuantity: 0,
        status: 'active',
        merchantId: null,
        description: ''
      },
      selectedProduct: null,
      dialogVisible: false,
      deleteDialogVisible: false,
      productIdToDelete: null
    };
  },
  methods: {
    fetchProducts() {
      const url = 'http://localhost:8080/api/products';
      axios.get(url)
          .then(response => {
            this.products = response.data;
          })
          .catch(error => {
            ElMessage.error('获取产品列表失败: ' + error.message);
            console.error('获取产品时出错:', error);
          });
    },
    fetchProductsByKeyword() {
      const url = this.searchKeyword
          ? `http://localhost:8080/api/products/search?keyword=${this.searchKeyword}`
          : 'http://localhost:8080/api/products';

      axios.get(url)
          .then(response => {
            this.products = response.data;
          })
          .catch(error => {
            ElMessage.error('获取产品列表失败: ' + error.message);
            console.error('获取产品时出错:', error);
          });
    },
    showProductForm() {
      this.selectedProduct = null;
      this.productForm = {
        productName: '',
        price: 0,
        stockQuantity: 0,
        status: 'active',
        merchantId: null,
        description: ''
      };
      this.dialogVisible = true;
    },
    editProduct(product) {
      this.selectedProduct = product;
      this.productForm = {
        productName: product.productName,
        price: product.price,
        stockQuantity: product.stockQuantity,
        status: product.status,
        merchantId: product.merchantId,
        description: product.description || ''
      };
      this.dialogVisible = true;
    },
    clearForm() {
      this.selectedProduct = null;
      this.productForm = {
        productName: '',
        price: 0,
        stockQuantity: 0,
        status: 'active',
        merchantId: null,
        description: ''
      };
    },
    saveProduct() {
      const url = this.selectedProduct
          ? `http://localhost:8080/api/products/${this.selectedProduct.productId}`
          : 'http://localhost:8080/api/products';

      const method = this.selectedProduct ? 'put' : 'post';

      const productData = {
        merchantId: this.productForm.merchantId,
        productName: this.productForm.productName,
        price: this.productForm.price,
        stockQuantity: this.productForm.stockQuantity,
        status: this.productForm.status,
        description: this.productForm.description
      };

      axios[method](url, productData)
          .then(() => {
            ElMessage.success(this.selectedProduct ? '产品更新成功' : '产品添加成功');
            this.fetchProducts(); // 重新获取所有产品
            this.dialogVisible = false;
          })
          .catch(error => {
            ElMessage.error('操作失败: ' + error.message);
            console.error('保存产品时出错:', error);
          });
    },
    confirmDelete(productId) {
      this.productIdToDelete = productId;
      this.deleteDialogVisible = true;
    },
    deleteProduct() {
      axios.delete(`http://localhost:8080/api/products/${this.productIdToDelete}`)
          .then(() => {
            ElMessage.success('产品删除成功');
            this.fetchProducts(); // 重新获取所有产品
            this.deleteDialogVisible = false;
          })
          .catch(error => {
            ElMessage.error('删除失败: ' + error.message);
            console.error('删除产品时出错:', error);
          });
    }
  },
  mounted() {
    this.fetchProducts(); // 初始加载所有产品
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
