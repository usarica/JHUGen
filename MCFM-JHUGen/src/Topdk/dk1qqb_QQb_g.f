      subroutine dk1qqb_QQb_g(p,msq)
      implicit none
************************************************************************
*     Author: R.K. Ellis                                               *
*     January, 2012.                                                   *
*     calculate the element squared and subtraction terms              *
*     for the process                                                  *
*                                                                      *
*     q(-p1) +qbar(-p2)=nu(p3)+e+(p4)+b(p5)+bbar(p6)+e-(p7)+nubar(p8)  *
*     +g(p9) radiated from top in decay                                *
*                                                                      *
*     Top is kept strictly on-shell although all spin correlations     *
*     are retained.                                                    *
*                                                                      *
************************************************************************
      include 'constants.f'
      include 'ewcouple.f'
      include 'qcdcouple.f'
      include 'masses.f'
      include 'plabel.f'
      integer j,k,hb,hc,h12,j1,j2,h1,h2,hg,j2min
      double precision msq(-nf:nf,-nf:nf),p(mxpart,4)
      double precision fac,qqb,gg
      double complex  prop
      double complex  mtop(2,2,2),manti(2,2),mprod(2,2,2),mtot(2,2,2,2),
     & mabtot(2,2,2,2,2),mbatot(2,2,2,2,2),mqed(2,2,2,2,2),
     & mab(2,2,2,2),mba(2,2,2,2)
      parameter(j2min=2)

C----set all elements to zero
      do j=-nf,nf
      do k=-nf,nf
      msq(j,k)=0d0
      enddo
      enddo

      call toppaironshell(p,1,mprod,mab,mba)
      call tdecayg(p,3,4,5,9,mtop)
      call adecay(p,7,8,6,manti)

c--- q-qbar amplitudes
      do hb=1,2
      do hg=1,2
      do hc=1,2
      do h12=1,2
      mtot(hb,hg,hc,h12)=czip
      do j1=1,2
      do j2=j2min,2
      mtot(hb,hg,hc,h12)=mtot(hb,hg,hc,h12)+
     & mtop(hb,hg,j1)*mprod(j1,h12,j2)*manti(j2,hc)
      enddo
      enddo
      enddo
      enddo
      enddo
      enddo

      prop=dcmplx(zip,mt*twidth)**2
      fac=V*gwsq**4*gsq**2/abs(prop)**2*gsq*V/xn
c--- include factor for hadronic decays of W
      if (plabel(3) .eq. 'pp') fac=2d0*xn*fac
      if (plabel(7) .eq. 'pp') fac=2d0*xn*fac
      qqb=0d0
      do hb=1,2
      do hg=1,2
      do hc=1,2
      do h12=1,2
      qqb=qqb+fac*aveqq*abs(mtot(hb,hg,hc,h12))**2
      enddo
      enddo
      enddo
      enddo

c--- gg amplitudes
      do hb=1,2
      do hg=1,2
      do hc=1,2
      do h1=1,2
      do h2=1,2
      mabtot(hb,hg,h1,h2,hc)=czip
      mbatot(hb,hg,h1,h2,hc)=czip

      do j1=1,2
      do j2=j2min,2
      mabtot(hb,hg,h1,h2,hc)=mabtot(hb,hg,h1,h2,hc)+
     & mtop(hb,hg,j1)*mab(j1,h1,h2,j2)*manti(j2,hc)
      mbatot(hb,hg,h1,h2,hc)=mbatot(hb,hg,h1,h2,hc)+
     & mtop(hb,hg,j1)*mba(j1,h1,h2,j2)*manti(j2,hc)
      mqed(hb,hg,h1,h2,hc)=mabtot(hb,hg,h1,h2,hc)+mbatot(hb,hg,h1,h2,hc)
      enddo
      enddo

      enddo
      enddo
      enddo
      enddo
      enddo

      gg=0d0
      do hb=1,2
      do hg=1,2
      do hc=1,2
      do h1=1,2
      do h2=1,2
      gg=gg+fac*avegg*xn
     & *(abs(mabtot(hb,hg,h1,h2,hc))**2+abs(mbatot(hb,hg,h1,h2,hc))**2
     & -abs(mqed(hb,hg,h1,h2,hc))**2/xnsq)
      enddo
      enddo
      enddo
      enddo
      enddo

C---fill qb-q, gg and q-qb elements
      do j=-nf,nf
      if ((j .lt. 0) .or. (j .gt. 0)) then
          msq(j,-j)=qqb
      elseif (j .eq. 0) then
          msq(0,0)=gg
      endif
      enddo
      return
      end
