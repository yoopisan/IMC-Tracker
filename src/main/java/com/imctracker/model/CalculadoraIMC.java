package com.imctracker.model;

public class CalculadoraIMC {

    // Calcular el índice de masa corporal.
    public static double calcular(double peso, double estatura) {

        if (peso <= 0 || estatura <= 0) {
            throw new IllegalArgumentException(
                    "El peso y la estatura deben ser mayores que cero."
            );
        }

        return peso / (estatura * estatura);
    }

    // Obtener la clasificación correspondiente al IMC.
    public static String clasificar(double imc) {

        if (imc < 18.5) {
            return "Bajo peso";
        } else if (imc < 25) {
            return "Peso normal";
        } else if (imc < 30) {
            return "Sobrepeso";
        } else if (imc < 35) {
            return "Obesidad grado I";
        } else if (imc < 40) {
            return "Obesidad grado II";
        } else {
            return "Obesidad grado III";
        }
    }
}