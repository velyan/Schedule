# Schedule

TODO: Write a project description

## Implementation
The project is implemented using Model-View-ViewModel design pattern, where bindings are used to propagate changes in presented data to the view.

**Bindings** - In order to enable bindings while avoiding the complexity of frameworks such as ReactiveCocoa, I’ve considered the following potential solutions:
  * KVO
  * Property observers as described here http://rasic.info/bindings-generics-swift-and-mvvm/
  
Since KVO requires a lot of bookkeeping related to adding and removing observers and works on NSObject subclasses exclusively, I have chosen the second option. 
Class Dynamic implements the property observer solution and furthermore supports multiple observers.

### 1. Appointment creator interface

**View** - The view is implemented in ScheduleCreatorViewController and is organized so that components are represented by cells in a table view. There are two types of cells:

  * ScheduleCreatorDateViewCell which displays date labels
  * ScheduleCreatorDatePickerCell which displays a date picker
Since begin date and end date section have a similar layout, two instances of the same cell (ScheduleCreatorDateViewCell) are used.

**ViewModel** - ScheduleCreatorViewViewModel is responsible for ScheduleCreatorViewController’s presentation logic and for creating children view models for each cell in the table view. 
ScheduleCreatorDatePickerViewViewModel  and ScheduleCreatorDateViewViewModel  expose properties for the respective views to bind to and display data formatted correctly. 

А binding exists in ScheduleCreatorViewViewModel  between children view models such that when the picker view model’s date updates, begin date and end date view models are updated as well. 

**Model** - ScheduleModel encapsulates an object that has a begin and end date. An instance of this object may be passed to ScheduleCreatorViewViewModel upon creation. 

###2. Schedule overview interface

In order to display an overview of items created through ScheduleCreatorViewController’s  interface, a mechanism to save and item had to be implemented first. Since Core Data is most frequently used in scenarios like this one, I went on and implemented the stack. 
  
**Data Persistence** - DataController is the class that wraps core data. 

**View** - An additional view controller OverviewViewController has been created to display a list of schedule items. Similar to ScheduleCreatorViewViewModel it displays data in a table view.
OverviewDetailViewCell represents a schedule. 

**ViewModel** - OverviewViewViewModel is responsible for fetching ScheduleModel objects from core data, sorting them and creating OverviewDetailViewViewModels for each of these models. It can also delete model objects from code data when instructed to do so  by the view.
OverviewDetailViewViewModel exposes properties that the view can bind to to display data correctly formatted. 

**Model** - ScheduleModel has been refactored to extend NSManagedObject and is used to display data in OverviewViewController.

## History

TODO: Write history

## Credits

TODO: Write credits

## License

TODO: Write license
