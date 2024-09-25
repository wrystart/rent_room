import NavBar from '../../components/NavBar/Index';
import SearchFilter from '../../views/RentRoomList/SearchFilter';


@Entry
@Component
struct RentRoomList {
  @StorageProp('topHeight') topHeight: number = 0;

  build() {
    Column() {
      NavBar({ title: '房源推荐' })
      SearchFilter()
    }
    .height('100%')
    .width('100%')
    .padding({ top: this.topHeight })

  }
}