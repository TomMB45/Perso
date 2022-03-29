package ex8;

import java.util.Scanner;

public class Exo8 {
    public static void main(String[] args) {
        Scanner clavier = new Scanner(System.in);
        final int nb_eleves = 2 ;
		int result=0,note_max=0,note;

        for (int value = 0; value < nb_eleves; value++) {
            System.out.print("Note de l'élève ");
            note = clavier.nextInt(); 
            if (note >= 0 && note <= 20){result = result+note;
                if(note>note_max){note_max = note;} 
            } else {System.out.println(false);}
        }
		clavier.close(); 
        System.out.println(result);
        System.out.println("Moyenne générale : " +(result/nb_eleves)+"\nMeilleur note : " + note_max);
    }
    
}
