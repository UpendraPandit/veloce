import 'package:flutter/material.dart';
class List extends StatefulWidget {
  static var id ='List';
  const List({Key? key}) : super(key: key);

  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        width:MediaQuery.of(context).size.width*1 ,
        height:MediaQuery.of(context).size.height*1 ,
      child: ListWheelScrollView(
        itemExtent:550,
        physics: FixedExtentScrollPhysics(),
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.5),
                color: Colors.blue,
              ),
              width:350,
              height:1250,

            child: Card(
                elevation: 10,
                child: Image.network('https://lh3.googleusercontent.com/83Wk0DJinnSgcxehDjr_BEyvLdORXVCkDUiy9eWRCDp0Tnldvb0mLCzCFWwm1SKUcW4VQpIjFVuBbMUo3L5Oi2c3XeiFGcR8CdM_S2D9oXc9AkcSZrXFPRgGWQE6sBlQMJ-bec03IKmKRXrjBgiEs0GNQ9geEWg9JiUnMztwNT8sCKK9mUuA1lcPkWQDFAqrI52iex8QcM-d1oM5twgBtQZI_BcnYqiMSfpM-IOI_iO5i21fxW3tCpoy2QJN_s9IeT28gk8kzxXjw8FE7lZZrwa4rtl6IXk1-H-j5diJyJXX_V4cZT1vX_DVwGl3dh9mu923OA0cRwndHBcRrOvkQvfFWUuXSjH-brIIIFKgJkruRAWd56MzV2kF5_XCrzS5MPl09JBkT84ByWeKG_dwqP3xtf1jfzlZgUIN2pRQReRH-v4IOIjsbyMR1ZzA7Tqqv5K8Q43T4CadILJCcsiQxu0u0SnLAR3yDJ_-qRh7gGjKyAXzC4nt7pnKlfRlsQyYJjb5DHwR3ofGhEKEqJloDy4muHiQNtcCRIKeCeRMhgOuiZ0ECbIzSQluAft8IiNHs_B4ZG_B-XLMeTlqJrj4Coakuhw4kKku5WkHxH4ygjYMARbXdEAaPzrsIUUeHPdXLwxNuOrP8kvLgwKNIUZqQ75z0xBEr7u_fAoqSHXg4jtiAON6gms561yTefvxPnM7EPWwrFEGEDTwQns93bh1ZeqhV_teH3Dhu56zCEqKhfB5Pl_7agWZMyP2lGegRAFJ9gDewIiVIwIr_-OUaQiVGX67z-gsIRiB_N62yPN7xx5FAUI548QFtzLkCQOWE_4fFq0brEl7tf5udnTZQlAE90TG4dhJX0ejHssYPnbCmiWKoqNQlu7IIoJlOYfxHV6MX4wPoAGfL67PIdA7qd1D_zA5NxG_d9EgWC_bsSpAm23G5AoEeS3noJQ_u4WmaKsZ7BDPukCvXuq_UqjJsBE7yLm4LvN6gjObOVR6HZXNN5ykXqAlFfyCax6BrQlyozELZNLJ88B4wGo9NyS2m9rsLZrBW5E=w700-h933-s-no?authuser=0',fit: BoxFit.fill,)),
            ),
          ),    Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.5),
                color: Colors.blue,
              ),
              width:350,
              height:1250,

            child: Card(
                elevation: 10,
                child: Image.network(fit: BoxFit.fill,'https://lh3.googleusercontent.com/GT9eYbmnt6OB5hpuvnsKSir6S9r6tvKT4-dnqgmoWqjLWa4QjuFV4nxTB2JkUYI5XKs34cMcpXch5ZjYn4ibjn8nVXhqIneebTkODm1qpg6oKb1O9LB20t34jXmHVXht6wGuQJEdCZ0IOuKorZyWer96zKAaUZEJBML9ELu30x0OYTWeggvnd82_cZ4frGmYk5z4x99piboyV7azIMsuAioO5h7Kpz7SIR8g2vyyIzqxHttYmw5TpO1yMfN98WewxuTuiiOB4meZV9M7bho_3QjKwkCQz36E7bKyEneUTq63Bh6bgkpTcZUW8UQWUry5UClLqho79URwcymvxekOUTLAgEoM4yt1aPKU_eyU9hodY37yZNJc_VG4tWhgG3lY0hEZkYb6R1McTSggSc6wSgUXZqbZuyZ_8MYLeEjl2k1wGjGU09FpLR7DtQqV2CDEFQ8vuYOS4Jm0gM--PtV8cZMBfOFRCzm_ZE6SsMdZhxBJOIVqDaxf7D_rADYdx9bjyorF8PfTmygAX6wyEJ0V38PnyKDKI-y85qGIwfn53mOqte_twTG0JdA4Vd5XxECljBagtSqZZDC8TCYVUAYb6wv12Y0sPHjOruKbu8rRoYYYH2Hl7BMQ52H__rsNlauCx3j778ywdGyZ_A3KGJRFzLRGOks2-kG4pMDPBjoMHItjkVhMn8-J9lbWsmiCxAUB-x_3_j37vS5RqQBh3g8sPYa_SAo6MtAp43eFf4HrfLbQK5JcKcR-eCwJfgZRXKGVsW65pWOyzygO5FxnYoqffYDq2Qjy_DOcU0oOTkMZuCpW61h_J-PfpAtGZ6lZmhLqgQA_xMbn0b-CHrOsmtfqxcPd2sFaaQaBPVNSdr_AcGVX_t5z7C3TC98gWpiUki67H-tw9YWTfipM14wXWpWF_snvAFZ3NpiWIhOOlF0CcTp2iZGCdMSjNUomKM9ALOsC2VdwqFBIKgJjvkT-4UjgANG29EY6YR5qH0VwA_XuBLiBc7tNOZ41F7S0VsHqbIvKWdl33C3A-wJWHkbtspr3SLaYmqo=w700-h933-s-no?authuser=0')),
            ),
          ),    Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.5),
                color: Colors.blue,
              ),
              width:350,
              height:1250,

            child: Card(
                elevation: 10,
                child: Image.network(fit: BoxFit.fill,'https://lh3.googleusercontent.com/xU7jXjSKRxHUeeCJihJlfp8l3STqDANvqmDgSEfVktY3eIktYK73p1GKieYPMFwYyc2QZkoBN4rM2qRxEm2rohqAruYlEMGHmdTV9MDx7c8e4p3RLLOramBad6Qy0XtUh76mlYlWm8Mytv8SV4mYB1FrkvCQnNR0mREmS5InNICbSRmMAeTdiFoyI4WA1RFWaBMHpJv91n1l5EpRKDgyXBhBxpReApEGgrR2J0W_9184lWImnZq0QST5pUlV_m6g-qe6sG-09cI-QZUjPfJw9k_Kf_UKNe60xfFEXUyHHbXxOHqln7WubOrOzIkHAflg9JGKl6FOXzA1YkSJOWVZD6sWPkCttcI3CZXDhBvTBt7UmU0auwuwq4KjVK8oJ1jD577_0NJDOE3Wg-Q2FYGC_bKkPPMBbzcKR0MDFeFylqB5iAUGnrBB4xsWze_iLgibmGwp7kK9bm91VrksrYzpI8KBVgoCU96EaLWV1XGnf3g25Y5RTiyM6S9Xit1IB8unkTzQkpisD0vv2aapj7LX1U7cQDE6IQ_0rNcgMF3R5Yh4hJnezm7JIYf858v8sI0j5-aXYxC2Stw4qSm5Y4LJy6dNa4sQ5uFrnuOjt2kz9xc32Lg0CD2cyOQ0j_G5vNtjv20S3NZtTBtLBSlmtj8DIKJjF49LefTLdUkyiSJfEhqmr7i0snyvszcjSFVqfuPorDctN-u3gCB2sDQ1IpsPGpjn5Zn85aVaGwHYyiWKPIWSxmgTpd6dErA3131qOXnpx0cCZ4hRDCx7Cwrh9WE_XG0yKcsqZzZnpvE7A2RAirVplTxuNrmj-8TNBmt3Ixt65NYBkr1qwVw87tuHi0z7hbfNve8Qgq6hrhxAwCcGEHGp6ga8GK6c5z7IvUdkO4ugyBEQ322KLTysBpmGCn8IXUGaq7o6M9YpcOG3BmwSIokcVdYl_gXrEmbzTKAkn00s7iZls5tvoZGpTnSHM8SVgXPN8zLBRMhbKE3TchBJqPXgLVDn0RrKTd7HeOH1dMm1tuay7uJBShe4adqyvDw6iXKIZ4E=w700-h933-s-no?authuser=0')),
            ),
          ),    Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.5),
                color: Colors.blue,
              ),
              width:350,
              height:1250,

            child: Card(
                elevation: 10,
                child: Image.network(fit: BoxFit.fill,'https://lh3.googleusercontent.com/1vLsvQS_96K8YFfxB3q1wTNMvNRfC1QBYIwx7NqYzqh6oPQigiEAZFrjgBxSVZj7FrI5daylQkng1OvjRTI3UOPBxeBOrcQqSqMl7Vwvy6JR1GZAgS40lSz-ojX11Wdh_TtI00DrkocQZLT4vveA3hLZ5lBXJPbtNqbBTyLhe4NrPOptQJW86j4fhq8E8JMMqQo9EACM5ylv5o01u3TvV22SkMJ43xkEFBXc8APZUSgTrNPibc-0StlVuOVAnSkrb7L33SHXLiIDmDlJo4IPycB0-a7PM1tRlYn8f38laL-PM583KgB7rSTRggsa3odgbfrtBWU5QnbkTOVt5f9ebEHH8YyNvDJL1r6SZ-1MVhlqtIqGZcp1i5OpWb78gpNRymkYLOotNAfH_h67EhamMvHxzecFRxvEpMaOHxZyK-cHENYHSnZ3FgD5_SBoKsM5uH8S__GXkZ8-wHkazKpVphhNwvEHJlyJ3u51m6MNtK9KlP4idHgHr_7twX6q2PiVscxUAt5FrWzqISTtOLvSXY4DK57-uPqQfC03Cg7KnJ5oyQ3Fxg6paAfpedPOV1btZjyxQilZiRhJk5RqPLI79rAOa61HdQ8KGVdvsZg_dOFBmyngiD64fTDe0wfbDcGq0ebMoi34ouMCmakScuGHC2p4zXQsEZMhKqA7928wWSWgOmWK-TcWW5BUd6ZSanFUxXuVFc0aKoKMbkRgilgi7hhD6b6zJDXjRaf6SBU_YcWx_e2rTIc4g52SjDRBSnpVddkgMZ2aLIcSxhj1s75ubPzbI3Fqn3Um5YdAb81X_FBxn2KNT-LxqjwCatmQDa8Qgmo7TkGQcm9N_NJ0F5vinR7eEL5dSbJk11gO-z5iO6YJmo9l8ZwiIhuiT_o_bK69IVoUfPBHlVcgdOfUgrnZrwGrIXIGzu4HonTReFr1LOahZ3swpcQi7kqM5wynZvMvLlW4XbaYJBiuahdUVADxMfwZbltwqtlZSVmxfmD-bsCH1wmMkW3TLs8TIaYwgOyCHmSnKoUYjr4zDgwySN9KLh9yCdg=w700-h933-s-no?authuser=0')),
            ),
          ),    Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.5),
                color: Colors.blue,
              ),
              width:350,
              height:1250,

            child: Card(
                elevation: 10,
                child: Image.network(fit: BoxFit.fill,'https://lh3.googleusercontent.com/-wryxoqdMuXc6aBzvyrftT43aAuVorX-9T6fvmYOzp35iB0NLii4obNmGchjoBRqyg7_Sm6dGx-Uh7omY9DjGY-GDvM1VB1JAeWTMniX72pmyM4oomFqHBIklSqiNx55fr8kgwqTzu3WvBBkO6RgzFJ7JrdY2IzY2Th8Ns3nHvQRcNh5Bh8nzl8l0crFsmVx0utE5DbaoUwByqBgSRzkqXgJczj3GM5b2HlZuygQK6mV57cIwa0da-1JFym9FdLegcX6G2mb5rfUlCa9_MSnLk0M8oPI4Bo7yaCauDAp1TlsxYh-9VZfXqb6JQmGucAkU29LG92Ws4EIr8FhMsWyqYyXOnh8lLpB5UZFaLLhY4UaWM1DKUVLhMBGHPdBJqhrwdT2hOnnBgdpVLa4Hy2SAB1eRty_6n3hpM97b4mYD_hRRGp2iOr-0DgSAMXpuKozrsvN8fZpIvJ-lQsftjD5-ZapwN3sVk5XzxcHnDThK-6S7JRTTJ-nRAetmlFWEaYSRKaGa_WHwmk4bTiAAyzCpekq2hpbRDkrKN7yE2Rf8t-2u-cdU1MyS9ut0bAn01HzZZxbii3XigG8gk4exfDmcwCcbs-D3F9SH9YsPf3cLlNKzWazaYYs9SsKyRm4nsFOyFHExcp6basNn8RgCXQELao_8qxSqUgnxszvhu50lgxDDGjxaL6ARs4PlQBPi-7QDp6yz9t3A7k060t5hmwdshTWNE7hNOQaRSSVbkuvkZ5JAQiPd8xzna0JtslFn9Odg9VRZiOqoZZAMnHcEUiOe6Xu1ZLVNkA-xcVV99qzX5bafBisi28FOWidWaBfbqTkJ5DMGOlnYlM5sBvwsYc5IyL2XC1mfuq3xfQY-4yL4ZmnqOVVZ6-4h4F_e77ktcbz_pvk7xXMbCVczfW5JyeQBn4x24Jzg6en0ihW9y4UQNf4wE3RHFCFqUbxvUYrGDYwG56uefw1SKf20oXh4qSjU-Rt1369asAfchYGNwir4AEOnqhAFO67OQuzxHORrB5Gez1ao4mZWbetsOFmkktHw-PDuEM=w700-h933-s-no?authuser=0')),
            ),
          ),        ],
      ),
      ),
    );
  }
}
