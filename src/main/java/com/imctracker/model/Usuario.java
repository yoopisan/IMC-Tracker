package com.imctracker.model;

public class Usuario {

    private int idUsuario;
    private String nombreCompleto;
    private String nombreUsuario;
    private String passwordHash;
    private int edad;
    private String sexo;
    private double estatura;

    // Constructor vacío
    public Usuario() {
    }

    // Constructor con datos del usuario
    public Usuario(String nombreCompleto, String nombreUsuario,
                   String passwordHash, int edad, String sexo,
                   double estatura) {

        this.nombreCompleto = nombreCompleto;
        this.nombreUsuario = nombreUsuario;
        this.passwordHash = passwordHash;
        this.edad = edad;
        this.sexo = sexo;
        this.estatura = estatura;
    }

    // Getters y setters
    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombreCompleto() {
        return nombreCompleto;
    }

    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public int getEdad() {
        return edad;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public double getEstatura() {
        return estatura;
    }

    public void setEstatura(double estatura) {
        this.estatura = estatura;
    }
}
