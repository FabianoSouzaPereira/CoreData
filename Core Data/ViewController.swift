//
//  ViewController.swift
//  Core Data
//
//  Created by Fabiano De Souza Pereira on 07/03/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

       // addProduto(context: context, descricao: "iFone 13",cor: "azul", preco: 1229.99)
       // addProduto(context: context, descricao: "iFone 12",cor: "branco", preco: 800.45)
       // addProduto(context: context, descricao: "zumaFone",cor: "verde", preco: 905.96)
       // addProduto(context: context, descricao: "Macbook BigSure",cor: "preto", preco: 945.55)
        
        listaProdutos(context: context)

      //  addUsuario(context: context, nome: "Pedro das Candangas", idade: 34, login: "pedrobala", senha: "1234566")
      //  addUsuario(context: context, nome: "Zuca vim", idade: 35, login: "zucazum", senha: "422432")
      //  addUsuario(context: context, nome: "Lucas Pedro", idade: 34, login: "luquinha", senha: "45252412")
        
       // listaUsuarios(context: context)

    }
    
    
    func addProduto(context: NSManagedObjectContext, descricao: String, cor: String, preco: Double){
        
               /* insert produto */
               let produto = NSEntityDescription.insertNewObject(forEntityName: "Produto", into: context)
       
               /* Configura produto  */
               produto.setValue(descricao, forKey: "descricao")
               produto.setValue(cor, forKey: "cor")
               produto.setValue(preco, forKey: "preco")
       
               /* Salvar (Persistir) os dados */
               do {
                   try context.save()
                   print("Dados salvos com sucesso.")
               } catch {
                   print("Erro ao salvar os dados!")
               }
    }
    
    func addUsuario(context: NSManagedObjectContext, nome: String, idade: Int16, login: String, senha: String){
        /* Criar entidade */
        let usuario = NSEntityDescription.insertNewObject(forEntityName: "Usuario", into: context)
        
        /* conviguar objeto */
        usuario.setValue(nome, forKey: "nome")
        usuario.setValue(idade, forKey: "idade")
        usuario.setValue(login, forKey: "login")
        usuario.setValue(senha, forKey: "senha")
        
        
        /* Salvar (Persistir) os dados */
        do {
            try context.save()
            print("Dados salvos com sucesso.")
        } catch {
            print("Erro ao salvar os dados!")
        }
        
    }
    
    func listaProdutos(context: NSManagedObjectContext){
        /* recuperar Produtos */
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Produto")
        
        /* Ordenacao de A-Z e Z-A */
        let ordenacaoAZ = NSSortDescriptor(key: "descricao", ascending: true)
       // let ordenacaoZA = NSSortDescriptor(key: "preco", ascending: true)
       // requisicao.sortDescriptors = [ordenacaoAZ, ordenacaoZA]
        
        /* Filter */
       // let predicate = NSPredicate(format: "descricao == %@", "Macbook BigSure")
       // let predicate = NSPredicate(format: "descricao contains [c] %@", "macbook") //[c] é caseinsensitive  e o %@ é curinga da segunda parte(Macbook)
       // let predicate = NSPredicate(format: "descricao beginswith [c] %@", "macbook")
       
        /* Combinação de filtros */
       // let filtroDescricao = NSPredicate(format: "descricao contains [c] %@", "iFone")
       // let filtroPreco = NSPredicate(format: "preco >= %@", "945.65")
        
      //  let combinacaoFiltro = NSCompoundPredicate(andPredicateWithSubpredicates: [filtroDescricao, filtroPreco])
      //  let combinacaoFiltro = NSCompoundPredicate(orPredicateWithSubpredicates: [filtroDescricao, filtroPreco])
        
        requisicao.sortDescriptors = [ordenacaoAZ]
       // requisicao.predicate = predicate
       // requisicao.predicate = combinacaoFiltro
        
        do {
            let produtos = try context.fetch(requisicao)
            if produtos.count > 0 {
                for produto in produtos as! [NSManagedObject] {
                    if let descricao = produto.value(forKey: "descricao"){
                        if let cor = produto.value(forKey: "cor"){
                            if let preco = produto.value(forKey: "preco"){
                                
                                print(String(describing: descricao) + " | " + String(describing: cor) + " | " + String(describing: preco) )
                                
                            }
                        }
                    }
                }

            }else{
                print("Nenhum produto encontrado!")
            }

        } catch {
            print("Erro ao recuperar registro!")
        }
    }
    
    func listaUsuarios(context: NSManagedObjectContext){
        
        /* Recuperar usuarios */
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")

        let ordenacaoAZ = NSSortDescriptor(key: "nome", ascending: true)
        let ordenacaoIdade = NSSortDescriptor(key: "idade", ascending: true)
        
        requisicao.sortDescriptors = [ordenacaoAZ, ordenacaoIdade]
        
        do {
            let usuarios = try context.fetch(requisicao)
            if usuarios.count > 0 {
                for usuario in usuarios as! [NSManagedObject]{
                    if let nomeUsuario = usuario.value(forKey: "nome"){
                        print(nomeUsuario)
                    }
                }
            }
        } catch {
            print("Erro ao recuperar registro!")
        }
    }
    
}

