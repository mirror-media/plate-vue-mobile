<template>
  <div class="leading">
    <div class="leading-container">
      <div class="leading-slideshow" v-if="type === 'slideshow' && slideshowImgs.length > 0">
        <app-slider :option="sliderOption">
          <template slot-scope="props">
            <swiper-slide :is="props.slide" v-for="(o, i) in slideshowImgs" :key="`${i}-${Date.now()}`">
              <template v-if="$_leading_detectImgHref(o)">
                <a :href="$_leading_getHref(o)" target="_blank">
                  <img  :src="get(o, [ 'image', 'url' ])"
                        :srcset="`${get(o, [ 'image', 'resizedTargets', 'mobile', 'url' ])} 800w,
                                    ${get(o, [ 'image', 'resizedTargets', 'tablet', 'url' ])} 1200w,
                                    ${get(o, [ 'image', 'resizedTargets', 'desktop', 'url' ])} 2000w`" />
                </a>
              </template>
              <template v-else>
                <img  :src="get(o, [ 'image', 'url' ])"
                        :srcset="`${get(o, [ 'image', 'resizedTargets', 'mobile', 'url' ])} 800w,
                                    ${get(o, [ 'image', 'resizedTargets', 'tablet', 'url' ])} 1200w,
                                    ${get(o, [ 'image', 'resizedTargets', 'desktop', 'url' ])} 2000w`" />
              </template>
            </swiper-slide>
          </template>
        </app-slider>
      </div>
      <div class="leading-image" v-else-if="type === 'image' && leadingImg">
        <div class="img">
          <img :src="get(leadingImg, [ 'image', 'url' ])"
                :srcset="`${get(leadingImg, [ 'image', 'resizedTargets', 'mobile', 'url' ])} 800w,
                          ${get(leadingImg, [ 'image', 'resizedTargets', 'tablet', 'url' ])} 1200w,
                          ${get(leadingImg, [ 'image', 'resizedTargets', 'desktop', 'url' ])} 2000w`" />
        </div>
      </div>
      <div class="leading-video" v-else-if="type === 'video' && leadingVideo">
        <div class="video">
          <video controls ref="video">
            <source :src="get(leadingVideo, [ 'video', 'url' ])" :type="get(leadingVideo, [ 'video', 'filetype' ])" />
          </video>
        </div>
      </div>
      <div class="leading-embedded" v-else-if="type === 'embedded' && leadingEmedded">
        <div class="embedded" v-html="leadingEmedded"></div>
      </div>
    </div>
  </div>
</template>

<script>
import { get, indexOf, split } from 'lodash'
import Slider from 'src/components/Slider.vue'

export default {
  components: {
    'app-slider': Slider
  },
  computed: {
    sliderOption () {
      return {
        autoplay: 3000,
        paginationable: false,
        paginationClickable: true,
        paginationHide: false,
        setNavBtn: true
      }
    },
    slideshowImgs () {
      return get(this.mediaData, [ 'images', 'items' ], [])
    },
    leadingImg () {
      return get(this.mediaData, [ 'heroImage' ])
    },
    leadingVideo () {
      return get(this.mediaData, [ 'heroVideo' ])
    },
    leadingEmedded () {
      return get(this.mediaData, [ 'embed' ])
    }
  },
  methods: {
    $_leading_detectImgHref (item) {
      return indexOf(item.keywords, '@') !== -1
    },
    $_leading_getHref (item) {
      return split(item.keywords, '@-')[1]
    },
    get
  },
  name: 'leading',
  props: {
    mediaData: {
      default: () => { return {} }
    },
    type: {
      default: () => { return {} }
    }
  }
}

</script>
<style lang="stylus" scoped>
  .leading
    width 50%
    margin 0 auto

    .leading-container
      position relative
      padding-top 56.25%
      width 100%
      height 0

      .leading-slideshow
        position absolute
        top 0
        left 0
        width 100%
        height 100%        
        .swiper-container
          height 100%
          .swiper-wrapper
            height 100%
            .swiper-slide
              img
                width 100%
                object-fit contain
                max-height 100%

      .img
        position absolute
        top 0
        left 0
        width 100%
        height 100% 

        img
          width 100%
          object-fit contain
          max-height 100%

      .video
        position absolute
        top 0
        left 0
        width 100%
        height 100%   

        video
          width 100%
          object-fit contain
          max-height 100%

      .leading-embedded
        .embedded
          position absolute
          top 0
          left 0
          width 100%
          height 100% 
          display flex
          justify-content center
          align-items center

          > iframe
            max-height 100%

    &.event
      .leading-container
        padding-top 0
        height auto

        .leading-embedded
          .embedded
            position static
            display block

  @media (min-width 831px) and (max-width 1023px)
    .leading
      width 60%

  @media (min-width 768px) and (max-width 830px)
    .leading
      width 70%

  @media (min-width 600px) and (max-width 767px)
    .leading
      width 80%

  @media (min-width 500px) and (max-width 599px)
    .leading
      width 90%

  @media (min-width 0px) and (max-width 499px)
    .leading
      width 100%
</style>
