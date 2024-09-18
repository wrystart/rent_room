import { getHomeDataApi } from '../api/home';
import { BannerListDataSource, INavList } from '../models/HomeData';
import SwiperLayout from '../views/Home/SwiperLayout';
import SearchBar from '../views/Home/SearchBar';
import NavList from '../views/Home/NavList';
import { PADDING } from '../contants/size';

@Component
export default struct Home {
  @State bannerList: BannerListDataSource = new BannerListDataSource();
  @State navList: INavList = [];
  // 获取首页数据函数
  getHomeData = async () => {
    const result = await getHomeDataApi()
    this.bannerList.setList(result.bannerList)
    this.navList = result.navList;
  }

  // 生命周期函数：初始化渲染时触发
  aboutToAppear(): void {
    this.getHomeData()
  }

  build() {
    Scroll() {
      Stack() {
        Column() {
          // 轮播图组件
          SwiperLayout({ bannerList: this.bannerList })
          Column() {
            // 导航栏
            NavList({ navList: this.navList })
          }
          .width('100%').padding({ left: PADDING, right: PADDING })
        }
        .width('100%')

        // 搜索区
        SearchBar()
      }.width('100%').alignContent(Alignment.TopStart)
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .align(Alignment.TopStart)
  }
}