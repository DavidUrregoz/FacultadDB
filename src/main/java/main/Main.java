package main;

import integration.database.mysql.MySqlOperations;
import org.apache.log4j.PropertyConfigurator;
import java.sql.SQLException;
import java.util.Scanner;

import static util.enums.Log4jValues.LOG4J_PROPERTIES_FILE_PATH;
import static util.enums.SystemProperties.USER_DIR;

public class Main {

    private static final String SERVER = "sofka-training.cpxphmd1h1ok.us-east-1.rds.amazonaws.com";
    private static final String DATA_BASE_NAME = "davidUrregoZapata_facultad_10092021";
    private static final String USER = "sofka_training";
    private static final String PASSWORD = "BZenX643bQHw";

    private static  String SELECT_ALL;
    private static  String CALL_SP;

    private static final MySqlOperations mySqlOperations = new MySqlOperations();
    public static Scanner sc;
    public static void main(String[] args) throws Exception {
        PropertyConfigurator.configure(USER_DIR.getValue() + LOG4J_PROPERTIES_FILE_PATH.getValue());
        Scanner sc2=new Scanner(System.in);
        login();
        boolean salida = true;
        String entrada;
        int eleccion;
        while (salida){
            System.out.println("Menu \n" +
                    "1 ->Lista completa de Personas \n" +
                    "2 ->Lista completa de Materias \n" +
                    "3 ->Vista de Estudiantes Activos\n" +
                    "4 ->Vista de Profesores Activos\n" +
                    "5 ->Materias Disponibles y Horarios\n" +
                    "6 ->Lugares de Recidencia \n" +
                    "7 ->Busqueda De personas (cedula,nombre,ciudad,edad1,edad2) \n" +
                    "8 ->Ingresar Persona (cedula,Nombre,Apellido,Apellido,fecha de nacimiento,ciudad,esprofesor,estudiante)\n" +
                    "9 ->Ingresar Materia (salon, bloque,nombre de materia,creditos,dias,horas,presencial,laboratorio)\n" +
                    "10->Matricular estudiante a materia (Cedula,Codigo de materia)\n" +
                    "11->Asignar profesor a Materia (Cedula,Codigo de materia)\n" +
                    "12->Elominacion logica de personas (Cedula,true or false) \n" +
                    "13->Inhabilitar materia (Codigo de materia, true or false)\n" +
                    "14->Asignar una nota de una amteria a un estudiante (Codigo de materia,Cedula,Nota a Asignar)\n" +
                    "15->Profesores, Asignaturas y  Horarios\n" +
                    "16->Estudiantes y materias Matriculadas\n" +
                    "17->Materias de todos los departamentos\n" +
                    "18->Materias, Salones, Bloques y su Uso\n" +
                    "0 ->SALIR");
            entrada = sc2.next();
            if (comprobarNumero(entrada)) {
                eleccion = Integer.parseInt(entrada);
            } else {
                System.out.println("Ese no es un numero ");
                continue;
            }
            switch (eleccion){
                case 0:
                    salida=false;
                    break;
                case 1:
                    selectAllFromPersona();
                    break;
                case 2:
                    selectAllFromMateria();
                    break;
                case 3:
                    selectVistaEstudiantes();
                    break;
                case 4:
                    selectVistaProfesores();
                    break;
                case 5:
                    selectVistaMaterias();
                    break;
                case 6:
                    spLugaresRecidencia();
                    break;
                case 7:
                    spFiltarPersona();
                    break;
                case 8:
                    spIngresarPersona();
                    break;
                case 9:
                    spIngresarMateria();
                    break;
                case 10:
                    spMatricular();
                    break;
                case 11:
                    spAsignar();
                    break;
                case 12:
                    spEliminarPersona();
                    break;
                case 13:
                    spEliminarMateria();
                    break;
                case 14:
                    spNotaestudiante();
                    break;
                case 15:
                    psJoinProfesores();
                    break;
                case 16:
                    psJoinEstudiantes();
                    break;
                case 17:
                    psJoinDepartamento();
                    break;
                case 18:
                    psJoinMateriasBloque();
                    break;
            }
        }
        logout();
    }



    public static boolean comprobarNumero(String n){
        if(n.matches("[+-]?\\d*(\\.\\d+)?"))
            return true;
        return false;
    }

    private static void login(){
        mySqlOperations.setServer(SERVER);
        mySqlOperations.setDataBaseName(DATA_BASE_NAME);
        mySqlOperations.setUser(USER);
        mySqlOperations.setPassword(PASSWORD);
    }

    private static void selectAllFromPersona() throws SQLException {
        alterarSeleccionar("persona");
        mySqlOperations.setSqlStatement(SELECT_ALL);
        sentecia();
    }

    private static void selectAllFromMateria() throws SQLException {
        alterarSeleccionar("materia");
        mySqlOperations.setSqlStatement(SELECT_ALL);
        sentecia();
    }

    private static void selectVistaEstudiantes() throws SQLException {
        alterarSeleccionar("vista_estudiantes");
        mySqlOperations.setSqlStatement(SELECT_ALL);
        sentecia();
    }

    private static void selectVistaProfesores() throws SQLException {
        alterarSeleccionar("vista_esprofesores");
        mySqlOperations.setSqlStatement(SELECT_ALL);
        sentecia();
    }

    private static void selectVistaMaterias() throws SQLException {
        alterarSeleccionar("materias_disponibles");
        mySqlOperations.setSqlStatement(SELECT_ALL);
        sentecia();
    }

    private static void spLugaresRecidencia() throws SQLException {
        alterarProcedimientos("sp_listar_personas()");
        mySqlOperations.setSqlStatement(CALL_SP);
        sentecia();
    }

    private static void spFiltarPersona() throws SQLException {
        System.out.println("Ingrese de esta manera los parametros = 1033342050,David,Amaga,20,28 ");
        sc = new Scanner(System.in);
        String temporal = sc.nextLine();
        String[] parameters = temporal.split(",");
        temporal=("sp_personas_parametrico(\""+parameters[0]+"%\",\""+parameters[1]+"%\",\""+parameters[2]+"%\","+parameters[3]+","+parameters[4])+")";
        alterarProcedimientos(temporal);
        mySqlOperations.setSqlStatement(CALL_SP);
        sentecia();
    }

    private static void spIngresarPersona() throws SQLException {
        System.out.println("Ingrese de esta manera los parametros = 1033342050,David,Urrego,Zapata,1997-04-17,Amaga,false,true");
        sc = new Scanner(System.in);
        String temporal = sc.nextLine();
        String[] parameters = temporal.split(",");
        temporal=("sp_ingresar_persona(\""+parameters[0]+"\",\""+parameters[1]+"\",\""+parameters[2]+"\",\""+parameters[3]+"\",\""+parameters[4]+"\",\""+parameters[5]+"\","+parameters[6]+","+parameters[7]+",true,@registros_alterados)");
        alterarProcedimientos(temporal);
        mySqlOperations.setSqlStatement(CALL_SP);
        sentecia();
    }

    private static void spIngresarMateria() throws SQLException {
        System.out.println("Ingrese de esta manera los parametros = 101,19,Filosofia,5,lunes-martes,8pm-10pm,true,true");
        sc = new Scanner(System.in);
        String temporal = sc.nextLine();
        String[] parameters = temporal.split(",");
        temporal=("sp_ingresar_materia("+parameters[0]+","+parameters[1]+",\""+parameters[2]+"\","+parameters[3]+",\""+parameters[4]+"\",\""+parameters[5]+"\","+parameters[6]+","+parameters[7]+",true,@respuesta)");
        alterarProcedimientos(temporal);
        mySqlOperations.setSqlStatement(CALL_SP);
        sentecia();
        //call sp_ingresar_materia(101,19,"Geometria Vectoria",5,"Lunes-Sabado","8am a 10am",true,false,true,@respuesta);
    }
    private static void spMatricular() throws SQLException {
        System.out.println("Ingrese de esta manera los parametros = 1033342052,2");
        sc = new Scanner(System.in);
        String temporal = sc.nextLine();
        String[] parameters = temporal.split(",");
        temporal=("sp_ingresar_relacion_toma(\""+parameters[0]+"\","+parameters[1]+",@respuesta)");
        alterarProcedimientos(temporal);
        mySqlOperations.setSqlStatement(CALL_SP);
        sentecia();
        //call sp_ingresar_relacion_toma("1033342011",11,@respuesta);
    }

    private static void spAsignar() throws SQLException {
        System.out.println("Ingrese de esta manera los parametros = 1033342052,2");
        sc = new Scanner(System.in);
        String temporal = sc.nextLine();
        String[] parameters = temporal.split(",");
        temporal=("sp_ingresar_relacion_dicta(\""+parameters[0]+"\","+parameters[1]+",@respuesta)");
        alterarProcedimientos(temporal);
        mySqlOperations.setSqlStatement(CALL_SP);
        sentecia();
        //call sp_ingresar_relacion_toma("1033342011",11,@respuesta);
    }

    private static void spEliminarPersona() throws SQLException {
        System.out.println("Ingrese de esta manera los parametros = 1033342052,true");
        System.out.println("true para activar, false para desactivar");
        sc = new Scanner(System.in);
        String temporal = sc.nextLine();
        String[] parameters = temporal.split(",");
        temporal=("sp_update_activo_persona(\""+parameters[0]+"\","+parameters[1]+",@respuesta)");
        alterarProcedimientos(temporal);
        mySqlOperations.setSqlStatement(CALL_SP);
        sentecia();
        //call sp_update_activo_persona("245684787",false,@respuesta);
    }

    private static void spEliminarMateria() throws SQLException {
        System.out.println("Ingrese de esta manera los parametros = 15,true");
        System.out.println("true para activar, false para desactivar");
        sc = new Scanner(System.in);
        String temporal = sc.nextLine();
        String[] parameters = temporal.split(",");
        temporal=("sp_update_activo_materia("+parameters[0]+","+parameters[1]+",@respuesta)");
        alterarProcedimientos(temporal);
        mySqlOperations.setSqlStatement(CALL_SP);
        sentecia();
        //call sp_update_activo_materia(16,false,@respuesta);
    }

    private static void spNotaestudiante() throws SQLException {
        System.out.println("Ingrese de esta manera los parametros = 2,1033342050,4.9");
        System.out.println("true para activar, false para desactivar");
        sc = new Scanner(System.in);
        String temporal = sc.nextLine();
        String[] parameters = temporal.split(",");
        temporal=("sp_update_nota_materia("+parameters[0]+",\""+parameters[1]+"\","+parameters[2]+",@respuesta)");
        System.out.println("temporal = " + temporal);
        alterarProcedimientos(temporal);
        mySqlOperations.setSqlStatement(CALL_SP);
        sentecia();
        //call sp_update_nota_materia(2,"1032244123",4.4,@respuesta);
    }

    private static void psJoinProfesores() throws SQLException {
        alterarProcedimientos("sp_join_personas()");
        mySqlOperations.setSqlStatement(CALL_SP);
        sentecia();
    }

    private static void psJoinEstudiantes() throws SQLException {
        alterarProcedimientos("sp_join_estudiantes()");
        mySqlOperations.setSqlStatement(CALL_SP);
        sentecia();
    }

    private static void psJoinDepartamento() throws SQLException {
        alterarProcedimientos("sp_join_materias_departamento()");
        mySqlOperations.setSqlStatement(CALL_SP);
        sentecia();
    }

    private static void psJoinMateriasBloque() throws SQLException {
        alterarProcedimientos("sp_join_materias_bloque()");
        mySqlOperations.setSqlStatement(CALL_SP);
        sentecia();
    }





    private static void sentecia() throws SQLException{
        mySqlOperations.executeSqlStatement();
        mySqlOperations.printResultSet();

    }

    private static void alterarSeleccionar(String vista){
        SELECT_ALL = String.format("select * from %s.%s", DATA_BASE_NAME,vista);
    }

    private static void alterarProcedimientos(String ps){
        CALL_SP = String.format("call %s ",ps);
    }


    private static void logout(){
        mySqlOperations.close();
    }

}
