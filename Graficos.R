library(ggplot2)
library(scales)
library(readxl)

# gráfico de prima anual
df <- readxl::read_excel("C:/Users/gsana/Documents/Proyecto_Contingencias_I/Proyecto_Conti.xlsm",
                         sheet = "Costo_actuarial_separado")


df_2025 <- subset(df, Año == 2025, select = c("Edad", "Sexo", "Prima"))


df_2025$Edad <- as.numeric(df_2025$Edad)


ggplot(df_2025, aes(x = Edad, y = Prima, color = Sexo)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  labs(
    title = "Prima anual por edad y sexo – Año 2025",
    x = "Edad",
    y = "Prima anual",
    color = "Sexo"
  ) +
  scale_y_continuous(labels = label_number(accuracy = 0.001)) +
  theme_minimal(base_size = 13)
