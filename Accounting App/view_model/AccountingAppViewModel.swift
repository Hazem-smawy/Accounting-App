//
//  AccountingAppViewModel.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 25/05/2023.
//

import Foundation
import SwiftUI
import CoreData
import Combine

class CoreDataManager  {
    static let instance = CoreDataManager()
    
    let container:NSPersistentContainer
    let context: NSManagedObjectContext
    
    
    init() {
        self.container = NSPersistentContainer(name: "AccountingDatabase2")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error load database \(error.localizedDescription)")
            }
        }
        context = container.viewContext
    }
    
    func save(){
        do {
            try context.save()
        }catch let error {
            print("Error Save data : \(error.localizedDescription)")
        }
    }
    
    /*
     func backup(backupName: String){
            let backUpFolderUrl = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask).first!
            let backupUrl = backUpFolderUrl.appendingPathComponent(backupName + ".sqlite")
            let container = NSPersistentContainer(name: "Your Project Name")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in })

            let store:NSPersistentStore
            store = container.persistentStoreCoordinator.persistentStores.last!
            do {
                try container.persistentStoreCoordinator.migratePersistentStore(store,to: backupUrl,options: nil,withType: NSSQLiteStoreType)
            } catch {
                print("Failed to migrate")
            }
        }
     
     d
     func restoreFromStore(backupName: String){

             print(DatabaseHelper.shareInstance.getAllUsers())
             let storeFolderUrl = FileManager.default.urls(for: .applicationSupportDirectory, in:.userDomainMask).first!
             let storeUrl = storeFolderUrl.appendingPathComponent("YourProjectName.sqlite")
             let backUpFolderUrl = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask).first!
             let backupUrl = backUpFolderUrl.appendingPathComponent(backupName + ".sqlite")

             let container = NSPersistentContainer(name: "YourProjectName")
             container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                 let stores = container.persistentStoreCoordinator.persistentStores

                 for store in stores {
                     print(store)
                     print(container)
                 }
                 do{
                     try container.persistentStoreCoordinator.replacePersistentStore(at: storeUrl,destinationOptions: nil,withPersistentStoreFrom: backupUrl,sourceOptions: nil,ofType: NSSQLiteStoreType)
                     print(DatabaseHelper.shareInstance.getAllUsers())
                 } catch {
                     print("Failed to restore")
                 }

             })

         }
     
     
     */
}

// ViewModel

class AccountingAppViewModel:ObservableObject {
    @Published var forHemMoney:Double = 0
    @Published var forYouMoney:Double = 0
    @Published var editModeOpen:Bool = false
    @Published var openDrawer:Bool = false
    
    // MARK: OBJECT ARRAYS
    @Published var curences:[Curency] = []
    @Published var customers:[Customer] = []
    @Published var accGroups:[AccGroup] = []
    @Published var customersAccount:[CustomerAccount] = []
   
    
    // MARK: ACCGROUP AND CURENCY GLOBAL IDS
    @Published var currentAccGroup:AccGroup?
    @Published var currentCurency:Curency?
    
    @Published var selectionTap:Int? = nil
    
    // MARK: COREDATA MANAGER
    let manager = CoreDataManager.instance
    
    // add new Customer from Home page
    
    // MARK: NEW CUSTOMER ATTRIBIOTS
    @Published var nameTextfild:String = ""
    @Published var descTextfild:String = ""
    @Published var phone:String = ""
    @Published var address:String = ""
    @Published var credit:Double = 0
    @Published var debit:Double = 0
    @Published var isShowingWhenAppear:Bool = false
    @Published var forYou:String = ""
    @Published var onYou:String = ""
    
    //MARK: IF THERE ARE ERROR
    
    @Published var isError:String? = nil
    
    @Published var statusNotification:Bool = false
    
    
    
    
    @Published var isUpdated:Bool = false
    
    @Published var isSnackbarShowing:Bool = false
    @Published var snakbar:SnackBar? = .init(message: "هذا الحساب موقف قم بتغير الاعدادات للتعديل", color: .red, icon: "exclamationmark.triangle.fill")
    
    @Published var editedJournal:Journal? = nil
    
    //MARK: personal info
    @Published var personalInfo:PersonalInfo? = nil
    let filter = NSPredicate(format: "beenDeleted == %@", "false")

    
    init () {
    
        fetchPersonalInfo()
        fetchCurences()
        fetchAccGroups()
        fetchCustomers()
        fetchCustomersAccount()
        
//        deleteAll()
//        fik()
    
    }
  
    func fik () {
        addAccGroup(name:  "محلي", status: true)
        addAccGroup(name: "العملاء", status: true)
        addAccGroup(name: "الموزعون", status: true)

        addCurence(name: "دولار امريكي", symbol: "د.ا", status: true)
        addCurence(name: "ريال يمني", symbol:"ر.ي", status: true)
        addCurence(name: "ريال سعودي", symbol:"ر.س", status: true)

//        addAccGroup(name:  "emplooyee", status: true)
//        addAccGroup(name: "local", status: true)
//        addAccGroup(name: "moose", status: true)
//        
//        addCurence(name:"dollar", symbol: "D.A", status: true)
//        addCurence(name: "Reyal Yemeny", symbol:"R.Y", status: true)
//        addCurence(name: "Reyal Soudy", symbol:"R.S", status: true)
        
    }
    
  
    
    func deleteAll(){
        

        customers.forEach { e in
            manager.context.delete(e)
            manager.save()
        }

        customersAccount.forEach { e in
            manager.context.delete(e)
            manager.save()
        }
        curences.forEach { e in
            manager.context.delete(e)
            manager.save()
        }
        accGroups.forEach { e in
            manager.context.delete(e)
            manager.save()
        }

        customersAccount.forEach { e in
            manager.context.delete(e)
            manager.save()
        }
        
        
        
    }
    
    //MARK: personal info portion
    func fetchPersonalInfo() {
        let request = NSFetchRequest<PersonalInfo>(entityName: "PersonalInfo")
        
        do {
            personalInfo = try manager.context.fetch(request).first
            
        }catch let error {
            print("Error Fetch Accounts: \(error.localizedDescription)")
        }
    }
    func addPersonalInfo(name:String,phone:String,address:String,email:String) {
        
        let person = PersonalInfo(context: manager.context)
        person.phone = phone
        person.name = name
        person.email = email
        person.address = address
        person.createdAt = Date.now
        savePerson()
        
        
    }
    func updatePersonInfo() {
        savePerson()
    }
    func savePerson(){
        manager.save()
        fetchPersonalInfo()
    }
    
    //MARK: groups curency
    func fetchGroupsOfAccGroupsAndCurency(accGroupId:String)  -> Set<String> {
        var dist  = Set<String>()
        
        customersAccount.forEach { accRes in
            if accGroupId == accRes.accGroupId && curences.contains(where: {$0.curencyId == accRes.curencyId}){
                dist.insert(accRes.curencyId ?? "" )
            }
        }
        
        return dist
    }
    //MARK: CustomerAccount
    
    
    
    
    func saveCustomersAccount() {
        
        customersAccount.removeAll()
        manager.save()
        fetchCustomersAccount()
        
        
    }
    func fetchCustomersAccount() {
        let request = NSFetchRequest<CustomerAccount>(entityName: "CustomerAccount")
        request.predicate = filter
        do {
            customersAccount = try manager.context.fetch(request)
        }catch let error {
            print("Error Fetch Accounts: \(error.localizedDescription)")
        }
    }
    
    
    func fetchCustomerAccountsForAccGroupAndCurency(accGroupId:String,curencyId:String) -> [CustomerAccount] {
        
        let filterCustomerAccounts = customersAccount.filter { cac in
            cac.curencyId == curencyId && cac.accGroupId == accGroupId && customers.contains(where: {$0.customerId == cac.customerId})
        }
        
        return filterCustomerAccounts
    }
    func fetchCustomerAccountJournal (customerId:String) -> [Journal] {
        let filterRes =  customersAccount.first(where: { cac in
            cac.curencyId == currentCurency?.curencyId && cac.accGroupId == currentAccGroup?.accGroupID
        })
        
        return filterRes?.journals?.allObjects as? [Journal] ?? []
    }
    
    func deleteCusomerAccount(customerAccount:CustomerAccount){
        customerAccount.beenDeleted = true
        saveCustomersAccount()
    }
    
    
    func addCustomersAccount(accGroup:AccGroup,registerAt:Date)  {
        if currentCurency == nil || !(currentCurency?.status ?? false ) {
            isSnackbarShowing = true
            snakbar = .init(message: " لم تقم باختيار العمله", color: .red, icon: "dollarsign.circle.fill")
           
           
            return
        }
        let newId = UUID().uuidString;
        var newCustomer :Customer? = customers.first { customer in
            customer.customerName == nameTextfild
            
           
        }
        
        if newCustomer == nil {
            
            
            
            
            newCustomer = Customer(context: manager.context)
            newCustomer?.customerId = newId
            newCustomer?.customerName = nameTextfild.trimmingCharacters(in: .whitespacesAndNewlines)
            newCustomer?.phone = phone.count > 1 ? phone : "xxxxxxxx"
            newCustomer?.address = address.count > 2 ? address :"لايوجد عنوان"
            newCustomer?.status = true
            newCustomer?.createdAt = Date.now
            
            
            saveCustomer()
        }
        
        
        var newCustomerAccount :CustomerAccount? = customersAccount.first ( where :{
            $0.customerId == newCustomer?.customerId &&  $0.curencyId == currentCurency?.curencyId &&  $0.accGroupId ==  accGroup.accGroupID
        })
        
        
        
        if newCustomerAccount == nil {
            
            newCustomerAccount = CustomerAccount(context: manager.context)
            newCustomerAccount?.accGroupId = currentAccGroup?.accGroupID
            newCustomerAccount?.curencyId = currentCurency?.curencyId
            newCustomerAccount?.customerId = newCustomer?.customerId
            newCustomerAccount?.customerAccountId = UUID().uuidString
            
            newCustomerAccount?.totalDebit = debit
            newCustomerAccount?.totalCredit = credit
            newCustomerAccount?.operationNum = 1
            newCustomerAccount?.status = true
            newCustomerAccount?.createdAt = Date.now
            let newJournal = Journal(context: manager.context)
            newJournal.journalId = UUID().uuidString
            newJournal.debit = debit
            newJournal.credit = credit
            newJournal.journalDetails = descTextfild.trimmingCharacters(in: .whitespacesAndNewlines)
            newJournal.registerAt = registerAt
            newJournal.createdAt = Date.now
            newJournal.modifiedAt = Date.now
            newCustomerAccount?.addToJournals(newJournal)
            
            isSnackbarShowing = true
            snakbar = .init(message: "تم اضافه هذا الحساب الئ مجموعه حساباتك", color: .green, icon: "person.fill.checkmark")
            
            saveCustomersAccount()
            
        }else {
            addJournal(customerAccount: newCustomerAccount!, registerAt: registerAt)
            saveCustomersAccount()
            isSnackbarShowing = true
            snakbar = .init(message: "تمه اضافه سجل الئ هذا الحساب", color: .green, icon: "person.crop.circle.badge.checkmark.fill")
           
        }
        
        
        
        
//                print("Curency :\(currentCurency)")
//                print("accGroup :\(accGroup)")
//                print("New Customer : \(newCustomer)")
//                print("new Account : \(newCustomerAccount)")
//
        
        saveCustomersAccount()
        saveCustomer()
        
        
    }
    
    //MARK: JOURNALS PORT
//    func fetchJournals(curencyId:String)->[Journal] {
//        let request = NSFetchRequest<Journal>(entityName: "Journal")
//        request.predicate =  NSPredicate(format: "beenDeleted == %@ && ", "false")
//        do {
//            return try manager.context.fetch(request)
//        }catch let error {
//            print("Error Fetch Accounts: \(error.localizedDescription)")
//            return []
//        }
//    }
    func addJournal(customerAccount:CustomerAccount,registerAt:Date) {
        
        let newJournal = Journal(context: manager.context)
        newJournal.journalId = UUID().uuidString
        newJournal.debit = debit
        newJournal.credit = credit
        newJournal.journalDetails = descTextfild
        newJournal.registerAt = registerAt
        newJournal.createdAt = Date.now
        newJournal.modifiedAt = Date.now
        //customerAccount.journals = [newJournal]
        customerAccount.addToJournals(newJournal)
        customerAccount.totalDebit = customerAccount.totalDebit + debit
        customerAccount.totalCredit = customerAccount.totalCredit + credit
        customerAccount.operationNum = customerAccount.operationNum + 1
        customerAccount.modifiedAt = Date.now
        saveCustomersAccount()
        isSnackbarShowing = true
        snakbar = .init(message: "تمه اضافه سجل الئ هذا الحساب", color: .green, icon: "person.crop.circle.badge.checkmark.fill")
        isUpdated.toggle()
        
    }
    
    func deleteJournal(journal:Journal,customerAccount:CustomerAccount) {
        customerAccount.removeFromJournals(journal)
        customerAccount.operationNum = customerAccount.operationNum - 1
        customerAccount.totalCredit -= journal.credit
        customerAccount.totalDebit -= journal.debit
        if customerAccount.operationNum == 0 {
            //            manager.context.delete(customerAccount)
            customerAccount.beenDeleted = true
        }
        saveCustomersAccount()
    }
    func updateJournal(journal:Journal,customerAccount:CustomerAccount) {
        journal.modifiedAt = Date.now
        customerAccount.totalDebit += journal.debit - journal.credit
        customerAccount.totalCredit +=  journal.credit - journal.debit
        saveCustomersAccount()
    }
    
    //MARK: CURENCY PART
    
    func fetchCurences(){
        let request = NSFetchRequest<Curency>(entityName: "Curency")
        request.predicate = filter
        do {
            curences = try manager.context.fetch(request)
        }catch let error {
            print("Error Fetch Accounts: \(error.localizedDescription)")
        }
    }
    
    func getCurencyDetails(curencyId:String) -> Curency {
        return curences.first { curency in
            curency.curencyId == curencyId
            
        } ?? Curency(context: manager.context)
    }
    func saveCurencey() {
        manager.save()
        fetchCurences()
    }
    func addCurence(name:String,symbol:String,status:Bool) {
        let newCurence = Curency(context: manager.context)
        newCurence.curencyId = UUID().uuidString
        newCurence.status = status
        newCurence.curencyName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        newCurence.curencySymbol = symbol.trimmingCharacters(in: .whitespacesAndNewlines)
        newCurence.createdAt = Date.now
        newCurence.beenDeleted = false
        isSnackbarShowing = true
        snakbar = .init(message: "تمت الاضافه بنجاح", color: .green, icon: "dollarsign.circle.fill")
        
        saveCurencey()
        
    }
    
    func deleteCurence(indexSet:IndexSet) {
        guard let index = indexSet.first else {return}
        
        if curences.count > 1 {
           
            let entity = curences[index]
           
            
            if customersAccount.contains(where: {$0.curencyId == entity.curencyId}) {
                isSnackbarShowing = true
                snakbar = .init(message: "هذه العمله تحتوي عده حسابات لايمكنك حذفها", color: .red, icon: "dollarsign.circle.fill")
                
            }else {
                manager.context.delete(entity)
                saveCurencey()
                isSnackbarShowing = true
                snakbar = .init(message: "تمت الحذف بنجاح", color: .green, icon: "dollarsign.circle.fill")
              
                
            }
        }else {
            
            isSnackbarShowing = true
            snakbar = .init(message: "اقل عدد للعملات ١", color: .red, icon: "exclamationmark.triangle.fill")
            
            
        }
        
    }
    func updateCurence(curency:Curency,name:String? , symbol:String?,status:Bool?){
        if symbol != nil {
            curency.curencySymbol = symbol?.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if name != nil {
            curency.curencyName = name?.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if status != nil {
            curency.status  = status!
        }
        isSnackbarShowing = true
        snakbar = .init(message: "تمت التعديل بنجاح", color: .green, icon: "exclamationmark.triangle.fill")
        
        saveCurencey()
    }
    
    
    //MARK: ACCGROUP PART
    
    func fetchAccGroups(){
        let request = NSFetchRequest<AccGroup>(entityName: "AccGroup")
        
        request.sortDescriptors = [NSSortDescriptor(keyPath: \AccGroup.createdAt, ascending: true)]
        request.predicate = filter
        do {
            accGroups = try manager.context.fetch(request)
        }catch let error {
            print("Error Fetch Accounts: \(error.localizedDescription)")
        }
    }
    
    func saveAccGroups() {
        manager.save()
        fetchAccGroups()
    }
    
    func addAccGroup(name:String,status:Bool) {
        let newAccGroup = AccGroup(context: manager.context)
        newAccGroup.accGroupID = UUID.init().uuidString
        newAccGroup.accGroupName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        newAccGroup.status = status
        newAccGroup.createdAt = Date.now
        newAccGroup.beenDeleted = false
        isSnackbarShowing = true
        snakbar = .init(message: "تمت الاضافه بنجاح", color: .green, icon:" folder.fill.badge.plus")
      
        saveAccGroups()
        
    }
    
    func deleteAccGroup(indexSet:IndexSet) {
        guard let index = indexSet.first else {return}
        
        let entity = accGroups[index]
        //        setAccGroupIds.remove(Int(entity.accGroupID))
        if accGroups.count > 1 {
           
            
            if customersAccount.contains(where: {$0.accGroupId == entity.accGroupID}) {
                isSnackbarShowing = true
                snakbar = .init(message: "هذا الحساب يحتوي عده حسابات لايمكنك حذفه", color: .red, icon:"exclamationmark.triangle.fill")
                
                
            }else {
                manager.context.delete(entity)
                saveAccGroups()
                isSnackbarShowing = true
                
                snakbar = .init(message: "تمت الحذف بنجاح", color: .green, icon:"folder.fill.badge.plus")
               
                
            }
        }else {
            isSnackbarShowing = true
            snakbar = .init(message: "اقل عدد للتصنيفات ١", color: .red, icon: "exclamationmark.triangle.fill")
           
            
        }
        
    }
    func updateAccGroup(accGroup:AccGroup,name:String? , status:Bool?){
        if status != nil {
            accGroup.status = status!
        }
        if name != nil {
            accGroup.accGroupName = name
        }
        isSnackbarShowing = true
        snakbar = .init(message:  "تم التعديل بنجاح", color: .green, icon:"folder.fill.badge.plus" )
        
        saveAccGroups()
    }
    
    
    //MARK: CUSTOMER PART
    func fetchCustomers(){
        let request = NSFetchRequest<Customer>(entityName: "Customer")
        request.predicate = filter
        do {
            customers = try manager.context.fetch(request)
        }catch let error {
            print("Error Fetch Accounts: \(error.localizedDescription)")
        }
        
    }
    
    func saveCustomer() {
        
        manager.save()
        fetchCustomers()
    }
    func addCustomer(name:String,number:String,address:String,status:Bool) {
        
        
        let newCustomer = Customer(context: manager.context)
        newCustomer.customerId = UUID.init().uuidString
        newCustomer.customerName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        newCustomer.phone = number.trimmingCharacters(in: .whitespacesAndNewlines)
        newCustomer.address = address.trimmingCharacters(in: .whitespacesAndNewlines)
        newCustomer.status = status
        newCustomer.createdAt = Date.now
        newCustomer.beenDeleted = false
        isSnackbarShowing = true
        snakbar = .init(message: "تمت الاضافه بنجاح", color: .green, icon: "person.fill.checkmark")
       
        saveCustomer()
        
    }
    
    func deleteCustomer(customer:Customer) {
        
       
        
        if customersAccount.contains(where: {$0.customerId == customer.customerId}) {
            isSnackbarShowing = true
            snakbar = .init(message: "هذا الحساب يحتوي عده حسابات لايمكنك حذفه", color: .red, icon:"exclamationmark.triangle.fill")
            
            
        }else {
            manager.context.delete(customer)
            saveCustomer()
            saveCustomersAccount()
            isSnackbarShowing = true
            snakbar = .init(message: "تمت الحذف بنجاح", color: .green, icon:"person.fill.xmark")
           
           
        }
     
       
    }
    func updateCustomer(customer:Customer,name:String?,number:String?,address:String? , status:Bool?){
        if status != nil {
            customer.status = status!
            if status == false {
                customersAccount.forEach { cac in
                    if cac.customerId == customer.customerId {
                        cac.status = false
                        
                    }
                }
            }
        }
        
        if name != nil {
            customer.customerName = name?.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if number != nil {
            customer.phone = number?.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if address != nil {
            customer.address = address?.trimmingCharacters(in: .whitespacesAndNewlines)
        }
       
        withAnimation {
            
            isSnackbarShowing = true
            snakbar = .init(message:"تمت التعديل بنجاح", color: .green, icon:"person.fill.checkmark")
           
           
        }
        saveCustomer()
        saveCustomersAccount()
        
    }
    // helper function
    
    
    
    func toogleEditMode() {
        withAnimation {
            
            editModeOpen.toggle()
        }
    }
    
    
    
}
