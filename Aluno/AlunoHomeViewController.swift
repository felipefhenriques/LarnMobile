//
//  AlunoHomeViewController.swift
//  Larn
//
//  Created by Rogerio Lucon on 05/11/20.
//

import UIKit
import CoreData

struct Section: Hashable {
    let id: UUID
    let type: String
    let title: String
    let subtitle: String
    let items: [Aula]
}

//struct Aula: Decodable, Hashable {
//    let id: Int
//    let tagline: String
//    let name: String
//    let subheading: String
//    let image: String
//    let iap: Bool
//}

class AlunoHomeViewController: UIViewController {
    
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Aula>?
    
    var sections: [Section] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sections = generateSections()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositeLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
        collectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: FeaturedCell.reuseIdentifier)
        collectionView.register(MediumTableCell.self, forCellWithReuseIdentifier: MediumTableCell.reuseIdentifier)
        collectionView.register(SmallTableCell.self, forCellWithReuseIdentifier: SmallTableCell.reuseIdentifier)
        
        createDataSource()
        realoadData()
    }
    
    func configure<T: SelfConfiguringCell> (_ cellType: T.Type, with aula: Aula, for indexPath: IndexPath) -> T {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to deque\(cellType)")
        }
        cell.configure(with: aula)
        return cell
    }
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Aula>(collectionView: collectionView) { collectionView, IndexPath, aula in
            switch self.sections[IndexPath.section].type {
            case "mediumTable":
                return self.configure(MediumTableCell.self, with: aula, for: IndexPath)
            case "smallTable":
                return self.configure(SmallTableCell.self, with: aula, for: IndexPath)
            default:
                return self.configure(FeaturedCell.self, with: aula, for: IndexPath)
            }
        }
        
        dataSource?.supplementaryViewProvider = {[weak self] collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader else {
                return nil
            }
            
            guard let fisrstApp = self?.dataSource?.itemIdentifier(for: indexPath) else {
                return nil
            }
            
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: fisrstApp) else {
                return nil
            }
            
            if section.title.isEmpty {
                return nil
            }
            
            sectionHeader.title.text = section.title
            sectionHeader.subtitle.text = section.subtitle
            return sectionHeader
        }
    }
    
    func realoadData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Aula>()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource?.apply(snapshot)
    }
    
    func createCompositeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionindex, layoutEnvironment in
            let section = self.sections[sectionindex]
            
            switch section.type {
            case "mediumTable":
                return self.createMediumSection(using: section)
            case "smallTable":
                return self.createSmallTableSection(using: section)
            default:
                return self.createFeaturedSection(using: section)
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    func createFeaturedSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(350))
        
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPaging
        
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    func createMediumSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .fractionalHeight(0.33))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = .init(top: 0, leading: 20, bottom: 5, trailing: -30)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalWidth(0.55))
        
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPaging
        
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    func createSmallTableSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .estimated(200))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(80))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
    
    //Implementar para gerar as secoes
    func generateSections() -> [Section] {
        
        var aulas:[Aula] = fetchData(entity: Aula.self) as! [Aula]
        var materias:[Materia] = fetchData(entity: Materia.self) as! [Materia]
        
        var sec: [Section] = []
        
        var featured: [Aula] = []
        
        for index in 0..<aulas.count {
            
            if index < 3 {
                featured.append(aulas[index])
                aulas.remove(at: index)
            }
            
        }

        let dev = aulas.filter { $0.materia?.materia == "Desenvolvimento"}
        let bus = aulas.filter { $0.materia?.materia == "Negocios"}
        let des = aulas.filter { $0.materia?.materia == "Design"}
        let fin = aulas.filter { $0.materia?.materia == "Finanças"}
        let mkt = aulas.filter { $0.materia?.materia == "Marketing"}
        let art = aulas.filter { $0.materia?.materia == "Artes"}
        
         
        sec.append(Section(id: UUID(), type: "feature", title: "Destaques da semana", subtitle: "escolhido para voce", items: featured))
        sec.append(Section(id: UUID(), type: "mediumTable", title: dev[0].materia?.materia ?? "Erro", subtitle: "Populares", items: dev))
        sec.append(Section(id: UUID(), type: "mediumTable", title: bus[0].materia?.materia ?? "Erro", subtitle: "Populares", items: bus))
        sec.append(Section(id: UUID(), type: "mediumTable", title: des[0].materia?.materia ?? "Erro", subtitle: "Populares", items: des))
        sec.append(Section(id: UUID(), type: "mediumTable", title: fin[0].materia?.materia ?? "Erro", subtitle: "Populares", items: fin))
        sec.append(Section(id: UUID(), type: "mediumTable", title: mkt[0].materia?.materia ?? "Erro", subtitle: "Populares", items: mkt))
        sec.append(Section(id: UUID(), type: "mediumTable", title: art[0].materia?.materia ?? "Erro", subtitle: "Populares", items: art))
        
        return sec
    }
    
    func fetchData<T:NSManagedObject>(entity: T.Type) -> [Any] {
        do {
            return try contex.fetch(T.fetchRequest())
        } catch {
            fatalError("Home nao puxa aula")
        }
    }
}


