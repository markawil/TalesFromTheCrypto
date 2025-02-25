//
//  PortfolioDataService.swift
//  CryptoApp
//
//  Created by Mark Wilkinson on 2/24/25.
//

import CoreData
import Foundation

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "PortfolioContainer")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
            
            self.getPortfolio()
        }
    }
    
    // MARK: Public
    
    func updatePortfolio(coin: Coin, amount: Double) {
        
        if let entity = savedEntities.first(where: { $0.coinId == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                remove(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    // MARK: Private
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: "PortfolioEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch (let error) {
            print("error fetching portfolio entities: \(error)")
        }
    }
    
    private func add(coin: Coin, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinId = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func remove(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch (let error) {
            print("error saving to contex in CoreData: \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
