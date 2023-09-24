using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace PRN211_Asssignment.Models
{
    public partial class PRJ_ProjectContext : DbContext
    {
        public PRJ_ProjectContext()
        {
        }

        public PRJ_ProjectContext(DbContextOptions<PRJ_ProjectContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Attendance> Attendances { get; set; } = null!;
        public virtual DbSet<Course> Courses { get; set; } = null!;
        public virtual DbSet<Group> Groups { get; set; } = null!;
        public virtual DbSet<Instructor> Instructors { get; set; } = null!;
        public virtual DbSet<Room> Rooms { get; set; } = null!;
        public virtual DbSet<Session> Sessions { get; set; } = null!;
        public virtual DbSet<Student> Students { get; set; } = null!;
        public virtual DbSet<TimeSlot> TimeSlots { get; set; } = null!;
        public virtual DbSet<User> Users { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            var builder = new ConfigurationBuilder()
                              .SetBasePath(Directory.GetCurrentDirectory())
                              .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true);
            IConfigurationRoot configuration = builder.Build();
            optionsBuilder.UseSqlServer(configuration.GetConnectionString("MyCnn"));
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Attendance>(entity =>
            {
                entity.HasKey(e => e.Aid);

                entity.ToTable("Attendance");

                entity.Property(e => e.Aid).HasColumnName("aid");

                entity.Property(e => e.Description)
                    .HasMaxLength(500)
                    .HasColumnName("description");

                entity.Property(e => e.Sesid).HasColumnName("sesid");

                entity.Property(e => e.Sid).HasColumnName("sid");

                entity.Property(e => e.Status).HasColumnName("status");

                entity.HasOne(d => d.Ses)
                    .WithMany(p => p.Attendances)
                    .HasForeignKey(d => d.Sesid)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Attendance_Session");

                entity.HasOne(d => d.Student)
                    .WithMany(p => p.Attendances)
                    .HasForeignKey(d => d.Sid)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Attendance_Student");
            });

            modelBuilder.Entity<Course>(entity =>
            {
                entity.ToTable("Course");

                entity.Property(e => e.CourseId).HasColumnName("CourseID");

                entity.Property(e => e.Cname)
                    .HasMaxLength(50)
                    .HasColumnName("CName");

                entity.Property(e => e.Code)
                    .HasMaxLength(10)
                    .IsFixedLength();
            });

            modelBuilder.Entity<Group>(entity =>
            {
                entity.ToTable("Group");

                entity.Property(e => e.GroupId).HasColumnName("GroupID");

                entity.Property(e => e.CourseId).HasColumnName("CourseID");

                entity.Property(e => e.Gname)
                    .HasMaxLength(10)
                    .IsUnicode(false)
                    .HasColumnName("GName");

                entity.Property(e => e.InstructorId).HasColumnName("InstructorID");

                entity.HasOne(d => d.Course)
                    .WithMany(p => p.Groups)
                    .HasForeignKey(d => d.CourseId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Group_Course");

                entity.HasOne(d => d.Instructor)
                    .WithMany(p => p.Groups)
                    .HasForeignKey(d => d.InstructorId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Group_Instructor");
            });

            modelBuilder.Entity<Instructor>(entity =>
            {
                entity.ToTable("Instructor");

                entity.Property(e => e.InstructorId)
                    .ValueGeneratedNever()
                    .HasColumnName("InstructorID");

                entity.Property(e => e.InstructorName).HasMaxLength(50);

                entity.Property(e => e.InstructorRollNumber)
                    .HasMaxLength(10)
                    .IsFixedLength();
            });

            modelBuilder.Entity<Room>(entity =>
            {
                entity.ToTable("Room");

                entity.Property(e => e.RoomId).HasColumnName("RoomID");

                entity.Property(e => e.Rname)
                    .HasMaxLength(10)
                    .IsUnicode(false)
                    .HasColumnName("RName");
            });

            modelBuilder.Entity<Session>(entity =>
            {
                entity.ToTable("Session");

                entity.Property(e => e.SessionId).HasColumnName("SessionID");

                entity.Property(e => e.Date).HasColumnType("date");

                entity.Property(e => e.GroupId).HasColumnName("GroupID");

                entity.Property(e => e.InstructorId).HasColumnName("InstructorID");

                entity.Property(e => e.RoomId).HasColumnName("RoomID");

                entity.Property(e => e.TimeSlotId).HasColumnName("TimeSlotID");

                entity.HasOne(d => d.Group)
                    .WithMany(p => p.Sessions)
                    .HasForeignKey(d => d.GroupId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Session_Group");

                entity.HasOne(d => d.Room)
                    .WithMany(p => p.Sessions)
                    .HasForeignKey(d => d.RoomId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Session_Room");

                entity.HasOne(d => d.TimeSlot)
                    .WithMany(p => p.Sessions)
                    .HasForeignKey(d => d.TimeSlotId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Session_TimeSlot");
            });

            modelBuilder.Entity<Student>(entity =>
            {
                entity.ToTable("Student");

                entity.Property(e => e.StudentId)
                    .ValueGeneratedNever()
                    .HasColumnName("StudentID");

                entity.Property(e => e.Dob).HasColumnType("date");

                entity.Property(e => e.FirstName)
                    .HasMaxLength(10)
                    .IsFixedLength();

                entity.Property(e => e.LastName).HasMaxLength(20);

                entity.Property(e => e.StudentRollNumber)
                    .HasMaxLength(10)
                    .IsFixedLength();

                entity.HasMany(d => d.Groups)
                    .WithMany(p => p.Students)
                    .UsingEntity<Dictionary<string, object>>(
                        "StudentGroup",
                        l => l.HasOne<Group>().WithMany().HasForeignKey("GroupId").OnDelete(DeleteBehavior.ClientSetNull).HasConstraintName("FK_StudentGroup_Group"),
                        r => r.HasOne<Student>().WithMany().HasForeignKey("StudentId").OnDelete(DeleteBehavior.ClientSetNull).HasConstraintName("FK_StudentGroup_Student"),
                        j =>
                        {
                            j.HasKey("StudentId", "GroupId");

                            j.ToTable("StudentGroup");

                            j.IndexerProperty<int>("StudentId").HasColumnName("StudentID");

                            j.IndexerProperty<int>("GroupId").HasColumnName("GroupID");
                        });
            });

            modelBuilder.Entity<TimeSlot>(entity =>
            {
                entity.ToTable("TimeSlot");

                entity.Property(e => e.TimeSlotId).HasColumnName("TimeSlotID");

                entity.Property(e => e.TimeFrom).HasMaxLength(5);

                entity.Property(e => e.TimeTo).HasMaxLength(5);
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.ToTable("User");

                entity.Property(e => e.UserId)
                    .ValueGeneratedNever()
                    .HasColumnName("UserID");

                entity.Property(e => e.Campus).HasMaxLength(20);

                entity.Property(e => e.InstructorId).HasColumnName("InstructorID");

                entity.Property(e => e.IsStudent).HasColumnName("isStudent");

                entity.Property(e => e.Password)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.StudentId).HasColumnName("StudentID");

                entity.Property(e => e.Username)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.HasOne(d => d.Instructor)
                    .WithMany(p => p.Users)
                    .HasForeignKey(d => d.InstructorId)
                    .HasConstraintName("FK_User_Instructor");

                entity.HasOne(d => d.Student)
                    .WithMany(p => p.Users)
                    .HasForeignKey(d => d.StudentId)
                    .HasConstraintName("FK_User_Student1");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
