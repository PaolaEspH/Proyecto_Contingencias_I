library(ggplot2)
library(scales)
library(tidyr)
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





df1 <- read_excel("C:/Users/gsana/Documents/Proyecto_Contingencias_I/Proyecto_Conti.xlsm",
                 sheet = "Costo_actuarial_pensionados")


ggplot(df1, aes(x = Pensión)) +
  geom_histogram(bins = 30, fill = "springgreen4", color = "white") +
  scale_x_continuous(labels = label_comma()) +
  labs(
    title = "Costo Actuarial Pensionados",
    x = "Beneficio acumulado (₡)",
    y = "Número de pensionados"
  ) +
  theme_minimal(base_size = 13)


colors()




df2 <- data.frame(
  Incremento = c(0.00, 0.01, 0.02, 0.03, 0.04),
  `4%` = c(543680058025, 654025379522, 787790727454, 949934867422, 1146451878171),
  `5%` = c(390099432171, 467549857945, 561254384285, 674623546622, 811774955988),
  `6%` = c(282694597284, 337464879877, 403594842988, 483445443680, 579863489275),
  `7%` = c(206926802338, 245939472631, 292944648080, 349586881859, 417846503490),
  `8%` = c(153011711293, 180993612589, 214635087799, 255088433951, 303739273372)
)


df_long <- pivot_longer(df2, cols = -Incremento, names_to = "Tasa_Descuento", values_to = "Costo")


df_long$Tasa_Descuento <- factor(df_long$Tasa_Descuento, levels = c("4%", "5%", "6%", "7%", "8%"))


ggplot(df_long, aes(x = Tasa_Descuento, y = as.factor(Incremento), fill = Costo)) +
  geom_tile() +
  geom_text(aes(label = comma(Costo, accuracy = 1e9)), color = "white", size = 3) +
  scale_fill_gradient(low = "#56B1F7", high = "#132B43", labels = label_comma()) +
  labs(
    title = "Análisis de sensibilidad: Costo actuarial",
    subtitle = "Mapa de calor por tasa de descuento e incremento salarial",
    x = "Tasa de descuento",
    y = "Incremento salarial",
    fill = "Costo (₡)"
  ) +
  theme_minimal(base_size = 13)
