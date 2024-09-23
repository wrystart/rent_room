// 设计稿总宽度
const DRAFT_WIDTH = 360

// 预览器获取不到屏幕宽度，给预览器默认宽度360
const windowWidth = AppStorage.get('windowWidth') as number || 360

// 将元素设计稿大小转化为真机中大小
export default function rvp(val: number) {
  /*
   *  计算元素真正的大小：
        元素在设计稿的大小 / 设计稿总宽度 = x / 真机宽度 （保证元素在不同设备占比相同）
   *    x = 元素在设计稿的大小 / 设计稿总宽度 * 真机宽度
   * */
  return val / DRAFT_WIDTH * windowWidth
}
