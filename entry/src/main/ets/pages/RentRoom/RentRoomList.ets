import NavBar from '../../components/NavBar/Index';
import SearchFilter from '../../views/RentRoomList/SearchFilter';
import RoomList from '../../views/RentRoomList/RoomList';


@Entry
@Component
struct RentRoomList {
  @StorageProp('topHeight') topHeight: number = 0;

  build() {
    Stack() {
      RoomList()
      SearchFilter()
      Row() {
        NavBar({ title: '房源推荐' })
      }.width('100%').backgroundColor($r('app.color.white'))
    }
    .height('100%')
    .width('100%')
    .padding({ top: this.topHeight })
    .alignContent(Alignment.TopStart)
  }
}