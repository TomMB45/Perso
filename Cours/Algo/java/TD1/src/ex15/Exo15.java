package ex15;
import java.util.Scanner;

public class Exo15 {
    private static boolean palindrome(String str) {
        char[] tabchar = new char[str.length()];
        tabchar=str.toCharArray(); 

        for (int i=0 ; i < tabchar.length; i++){
            if (tabchar[i] != tabchar[tabchar.length-1-i]){
                return false; 
            } 
        }
        return true ; 
    }
    public static void main(String[] args) {
        String str = new String(); 
        Scanner clavier = new Scanner(System.in); 

        System.out.println("Mot");
		str = clavier.nextLine();
        clavier.close(); 

        if (palindrome(str)) {
            System.out.println("Le mot : " + str+ " est bien un palindrome !");
        } else {System.out.println("Le mot : " + str+ " n'est pas un palindrome !");
        }
    }
    
}
