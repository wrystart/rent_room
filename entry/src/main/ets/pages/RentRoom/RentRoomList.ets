import NavBar from '../../components/NavBar/Index';
import SearchFilter from '../../views/RentRoomList/SearchFilter';
import RoomList from '../../views/RentRoomList/RoomList';


@Entry
@Component
struct RentRoomList {
  @StorageProp('topHeight') topHeight: number = 0;

  build() {
    Column() {
      NavBar({ title: '房源推荐' })
      SearchFilter()
      RoomList()

    }
    .height('100%')
    .width('100%')
    .padding({ top: this.topHeight })

  }
}