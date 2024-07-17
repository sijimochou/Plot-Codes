##### 转置后
library(readxl)
library(ComplexHeatmap)
library(circlize)

# 设置工作目录
setwd('C:/Users/zyzhang2022/Desktop')

# 读取数据
df <- read_excel("./新建文件夹/bio_results_coembdg4101518.xlsx")

# 选择特定的列，这里我们使用module 4, 10, 15, 18的log值
module_columns <- c("module 4", "module 10", "module 15", "module 18")
selected_data <- df[, c("label_m", module_columns)]

# 将数据转换为矩阵并转置
data_matrix <- as.matrix(selected_data[, -1])
rownames(data_matrix) <- selected_data$label_m
data_matrix <- t(data_matrix)

# 保存转置后的热图
png("Go/heatmap.png", width = 800, height = 250, res = 150)

group <- unique(colnames(data_matrix))
ng <- length(unique(group))

# 手动定义颜色向量
group_colors <- c("#FF5733", "#33FF57", "#5733FF", "#FF33A8", "#33A8FF")

top_Annotation <- ComplexHeatmap::HeatmapAnnotation(foo = ComplexHeatmap::anno_block(labels = sort(unique(group)),
                                                                                     labels_gp = grid::gpar(fontsize = 5, col = "black"),
                                                                                     gp = grid::gpar(fill = group_colors)))

Heatmap(data_matrix,
        name = "log value",
        # col = colorRamp2(seq(0, 2, length.out = length(my_colors)), my_colors),
        column_split = selected_data$label_m,
        cluster_rows = FALSE,
        cluster_columns = FALSE,
        show_column_names = FALSE,
        row_names_gp = gpar(fontsize = 10),
        column_names_gp = gpar(fontsize = 0),
        top_annotation = top_Annotation,
)

dev.off()