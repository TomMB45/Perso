public class Heros extends Personne{
    private String Pouvoir; 

    public Heros(String Nom,String Pseudo, String Famille, String Genre,/*ArrayList<Personne> Amis,ArrayList<Personne> Ennemis,*/String Pouvoir_ce_super_hero) throws Exception{
        super(Nom,Pseudo,Genre,Famille); 
        Pouvoir=Pouvoir_ce_super_hero; 
        // Famille=Famille_Ce_Hero; 
    }
    
    // public String toString(){
    //     if (Famille.size()==0){
    //         return(Nom_Super_Hero+"est un "+super.Genre + " ayant pour super-pouvoirs : " + Power+"\nSes amis sont : "+super.Amis+"\n Ses ennemis sont : "+super.Ennemis); 
    //     } else {
    //     return(Nom_Super_Hero+"est un "+super.Genre + " appartenant à la famille " + Famille + " et ayant pour super-pouvoirs : " + Power+"\nSes amis sont : "+super.Amis+"\n Ses ennemis sont : "+super.Ennemis); }
    // }

    // public String getNom_Super_Hero() {
    //     return Nom_Super_Hero;
    // }

    public String getPouvoir() {
        return Pouvoir;
    }

}
    

